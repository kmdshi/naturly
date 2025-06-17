// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/feature/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/feature/schedule/domain/repository/userbase_repository.dart';

class UserBaseRepositoryImpl extends UserBaseRepository {
  final ScheduleSupabaseRemoteDS scheduleRemoteDs;
  UserBaseRepositoryImpl({required this.scheduleRemoteDs});

  @override
  Future<void> addUserDish(Dish dish) async {
    await scheduleRemoteDs.addUserDish(dish);
  }

  @override
  Future<void> addUserProduct(Product product) async {
    await scheduleRemoteDs.addUserProduct(product);
  }

  @override
  Future<List<Dish>> getUserDishes() async {
    final userDishes = await scheduleRemoteDs.getUserDishes().then(
      (dish) => dish.map((e) => Dish.fromJson(jsonEncode(e))).toList(),
    );

    return userDishes;
  }

  @override
  Future<List<Product>> getUserProducts() async {
    final userProducts = await scheduleRemoteDs.getUserProducts().then(
      (products) =>
          products.map((e) => Product.fromJson(jsonEncode(e))).toList(),
    );

    return userProducts;
  }

  @override
  Future<void> deleteUserDish(Dish dish) async {
    await scheduleRemoteDs.deleteUserDish(dish);
  }

  @override
  Future<void> deleteUserProduct(Product product) async {
    await scheduleRemoteDs.deleteUserProduct(product);
  }

  @override
  Future<void> editUserDish(Dish newDish, String oldTitle) async {
    await scheduleRemoteDs.editUserDish(newDish, oldTitle);
  }

  @override
  Future<void> editUserProduct(Product newProduct, String oldTitle) async {
    await scheduleRemoteDs.editUserProduct(newProduct, oldTitle);
  }
}
