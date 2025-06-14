// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/core/common/models/product_model.dart';
import 'package:naturly/src/core/common/services/food_service.dart';
import 'package:naturly/src/feature/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/feature/schedule/domain/repository/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleSupabaseRemoteDS scheduleRemoteDs;
  final FoodService foodService;
  ScheduleRepositoryImpl({
    required this.scheduleRemoteDs,
    required this.foodService,
  });
  @override
  Future<DayRation> generateDayRation(
    String day,
    int dayIndex,
    Human person,
  ) async {
    final productsJson = await scheduleRemoteDs.getUserProducts();

    final productJsonList = productsJson.map((e) => jsonEncode(e)).toList();

    final availableProducts =
        productJsonList.map((jsonString) {
          return Product.fromJson(jsonString);
        }).toList();

    final userDishes = await scheduleRemoteDs.getUserDishes();

    final morningDishes =
        userDishes
            .where((e) => e["mealType"] == 'Завтрак')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final lunchDishes =
        userDishes
            .where((e) => e["mealType"] == 'Обед')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final snackDishes =
        userDishes
            .where((e) => e["mealType"] == 'Перекус')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final dinnerDishes =
        userDishes
            .where((e) => e["mealType"] == 'Ужин')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    return foodService.generateDayRation(
      availableProducts,
      morningDishes,
      lunchDishes,
      snackDishes,
      dinnerDishes,
      day,
      dayIndex,
      person,
    );
  }

  @override
  Future<List<DayRation>> generateWeekRation(Human person) async {
    final availableProductsJson = await scheduleRemoteDs.getUserProducts();
    final availableProducts =
        availableProductsJson
            .map((e) => Product.fromJson(jsonEncode(e)))
            .toList();

    final userDishes = await scheduleRemoteDs.getUserDishes();

    final morningDishes =
        userDishes
            .where((e) => e["mealType"] == 'Завтрак')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final lunchDishes =
        userDishes
            .where((e) => e["mealType"] == 'Обед')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final snackDishes =
        userDishes
            .where((e) => e["mealType"] == 'Перекус')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    final dinnerDishes =
        userDishes
            .where((e) => e["mealType"] == 'Ужин')
            .map((e) => Dish.fromJson(jsonEncode(e)))
            .toList();

    return foodService.generateWeekRation(
      availableProducts,
      morningDishes,
      lunchDishes,
      snackDishes,
      dinnerDishes,
      person,
    );
  }

  @override
  Future<void> addUserRation(List<DayRation> ration) async {
    await scheduleRemoteDs.addOrUpdateUserRation(ration);
  }

  @override
  Future<List<DayRation>> getUserRation() async {
    final userRationJson = await scheduleRemoteDs.getUserRation();

    final List<DayRation> ration =
        userRationJson.isNotEmpty
            ? userRationJson.map<DayRation>((e) {
              DayRation dayRation = DayRation.fromMap(e);
              return dayRation;
            }).toList()
            : [];

    return ration;
  }
}
