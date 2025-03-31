// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:naturly/src/core/common/models/product_model.dart';

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
      print(e);
      return [];
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
      print(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getUserRation() async {
    try {
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception("User not authenticated");
      }

      return await supabase
          .from('Profiles')
          .select('week_ration')
          .eq('id', userId);
    } catch (e) {
      print('Error saving ration: $e');
      throw e;
    }
  }

  Future<void> addUserRation(List<DayRation> ration) async {
    try {
      final userId = supabase.auth.currentUser?.id;

      if (userId == null) {
        throw Exception("User not authenticated");
      }

      final List<Map<String, dynamic>> rationData =
          ration.map((dayRation) {
            return dayRation.toMap();
          }).toList();

      await supabase
          .from('Profiles')
          .update({'week_ration': rationData})
          .eq('id', userId);
    } catch (e) {
      print('Error saving ration: $e');
    }
  }

  Future<void> addUserProduct(Product product) async {
    final mapProduct = product.toMap();
    try {
      await supabase.from('Products').insert([
        {'id': supabase.auth.currentUser?.id.toString(), ...mapProduct},
      ]);
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUserDish(Dish dish) async {
    final mapProduct = dish.toMap();
    try {
      await supabase.from('Dishes').insert([
        {'id': supabase.auth.currentUser?.id.toString(), ...mapProduct},
      ]);
    } catch (e) {
      print(e);
    }
  }
}
