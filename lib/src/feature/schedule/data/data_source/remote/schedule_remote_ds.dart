// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:nanoid/async.dart';
import 'package:naturly/src/core/common/extensions/datetime_extension.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScheduleSupabaseRemoteDS {
  final SupabaseClient supabase;
  ScheduleSupabaseRemoteDS({required this.supabase});

  Future<List<Map<String, dynamic>>> getUserProducts() async {
    try {
      final products = await supabase
          .from('Products')
          .select()
          .filter('id', 'eq', supabase.auth.currentUser?.id.toString());
      return products;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getUserDishes() async {
    try {
      final products = await supabase
          .from('Dishes')
          .select()
          .filter('id', 'eq', supabase.auth.currentUser?.id.toString());
      return products;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> getUserRation() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      final weekKey = weekKeyFromDate(DateTime.now());

      if (userId == null) {
        throw Exception("User not authenticated");
      }

      final response =
          await supabase
              .from('Rations')
              .select('food_data')
              .eq('usid', userId)
              .eq('week_key', weekKey)
              .maybeSingle();

      final weekRation = List<Map<String, dynamic>>.from(
        response?['food_data'] ?? [],
      );
      return weekRation;
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrUpdateUserRation(List<DayRation> ration) async {
    final userId = supabase.auth.currentUser?.id;
    final today = DateTime.now();
    if (userId == null) throw Exception("User not authenticated");

    final weekKey = weekKeyFromDate(today);

    final existing =
        await supabase
            .from('Rations')
            .select('id, food_data')
            .eq('usid', userId)
            .eq('week_key', weekKey)
            .maybeSingle();

    if (existing == null) {
      await supabase.from('Rations').insert({
        'usid': userId,
        'food_data': ration.map((r) => r.toMap()).toList(),
        'week_key': weekKey,
        'share_id': await nanoid(8),
      });
      return;
    }

    final data = List<Map<String, dynamic>>.from(existing['food_data'] ?? []);

    for (final newDay in ration) {
      final index = data.indexWhere((d) => d['date'] == newDay.toMap()['date']);
      if (index != -1) {
        data[index] = newDay.toMap();
      } else {
        data.add(newDay.toMap());
      }
    }

    await supabase
        .from('Rations')
        .update({'food_data': data})
        .eq('usid', userId)
        .eq('week_key', weekKey);
  }

  String weekKeyFromDate(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    final sunday = monday.add(const Duration(days: 6));
    return '${monday.formatDate()} - ${sunday.formatDate()}';
  }

  Future<void> addUserProduct(Product product) async {
    final mapProduct = product.toMap();
    try {
      await supabase.from('Products').insert([
        {'id': supabase.auth.currentUser?.id.toString(), ...mapProduct},
      ]);
    } catch (e) {
      throw e;
    }
  }

  Future<void> addUserDish(Dish dish) async {
    final mapProduct = dish.toMap();
    try {
      await supabase.from('Dishes').insert([
        {'id': supabase.auth.currentUser?.id.toString(), ...mapProduct},
      ]);
    } catch (e) {
      throw e;
    }
  }
}
