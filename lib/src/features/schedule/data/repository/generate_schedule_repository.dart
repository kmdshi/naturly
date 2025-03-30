// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:naturly/src/core/services/food_service.dart';
import 'package:naturly/src/features/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/features/schedule/domain/models/day_ration_model.dart';
import 'package:naturly/src/features/schedule/domain/models/dish_model.dart';
import 'package:naturly/src/features/schedule/domain/models/human_profile.dart';
import 'package:naturly/src/features/schedule/domain/models/product_model.dart';
import 'package:naturly/src/features/schedule/domain/repository/generate_schedule_repository.dart';

class GenerateScheduleRepositoryImpl extends GenerateScheduleRepository {
  final ScheduleSupabaseRemoteDS scheduleRemoteDs;
  final FoodService foodService;
  GenerateScheduleRepositoryImpl({
    required this.scheduleRemoteDs,
    required this.foodService,
  });
  @override
  Future<DayRation> generateDayRation(
    String day,
    int dayIndex,
    Human person,
  ) async {
    final availableProducts = await scheduleRemoteDs
        .getAvailableProducts()
        .then((products) =>
            products.map((e) => Product.fromJson(jsonEncode(e))).toList());

    final userDishes = scheduleRemoteDs.getDayDishes();

    final morningDishes = userDishes["morning"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];

    final lunchDishes = userDishes["lunch"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];
    final snackDishes = userDishes["snack"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];
    final dinnerDishes = userDishes["dinner"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];

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
  Future<List<DayRation>> generateWeekRation(
    Human person,
  ) async {
    final availableProducts = await scheduleRemoteDs
        .getAvailableProducts()
        .then((products) =>
            products.map((e) => Product.fromJson(jsonEncode(e))).toList());

    final userDishes = scheduleRemoteDs.getDayDishes();

    final morningDishes = userDishes["morning"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];

    final lunchDishes = userDishes["lunch"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];
    final snackDishes = userDishes["snack"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];
    final dinnerDishes = userDishes["dinner"]
            ?.map((e) => Dish.fromJson(jsonEncode(e)))
            .toList() ??
        [];

    return foodService.generateWeekRation(availableProducts, morningDishes,
        lunchDishes, snackDishes, dinnerDishes, person);
  }
}
