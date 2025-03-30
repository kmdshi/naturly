// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:naturly/mock.dart';
import 'package:naturly/src/features/schedule/domain/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ScheduleSupabaseRemoteDS {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAvailableProducts() async {
    try {
      final products = await _supabase
          .from('Products')
          .select()
          .filter('id', 'eq', _supabase.auth.currentUser?.id.toString());
      return  products;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Map<String, List<dynamic>> getDayDishes() {
    return dishes;
  }

  Future<void> addUserProduct(Product product) async {
    final mapProduct = product.toMap();
    try {
      await _supabase.from('Products').insert([
        {
          'id': _supabase.auth.currentUser?.id.toString(),
          ...mapProduct,
        }
      ]);
    } catch (e) {
      print(e);
    }
  }
}
