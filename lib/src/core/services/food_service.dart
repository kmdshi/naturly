import 'dart:math';

import 'package:collection/collection.dart';
import 'package:naturly/src/core/domain/models/day_ration_model.dart';
import 'package:naturly/src/core/domain/models/dish_model.dart';
import 'package:naturly/src/core/domain/models/food_enums.dart';
import 'package:naturly/src/core/domain/models/human_profile.dart';
import 'package:naturly/src/core/domain/models/product_model.dart';

class FoodService {
  List<DayRation> generateWeekRation(
    List<Dish>? availableMorningDishes,
    List<Dish>? availableLunchDishes,
    List<Dish>? availableSnackDishes,
    List<Dish>? availableDinnerDishes,
    List<Dish> otherMorningDishes,
    List<Dish> otherLunchDishes,
    List<Dish> otherSnackDishes,
    List<Dish> otherDinnerDishes,
    Human person,
  ) {
    final pfc = person.calculateWeeklyMacronutrients();
    final ccals = person.calculateWeeklyCalories();
    double proteinLeft = pfc['protein']!;
    double fatsLeft = pfc['fats']!;
    double carbsLeft = pfc['carbs']!;
    double caloriesLeft = ccals;

    List<DayRation> weekRation = [];
    Map<Dish, int> selectedDishes = {};

    Map<ProductGroup, int> groupFrequency = {
      ProductGroup.grainsAndPotatoes: 4,
      ProductGroup.vegetablesFruitsAndBerries: 5,
      ProductGroup.dairyAndDairyProducts: 3,
      ProductGroup.fishPoultryMeatAndEggs: 5,
      ProductGroup.addedFatsNutsSeedsAndOilyFruits: 3,
      ProductGroup.sugarSweetsAndSnacks: 2,
      ProductGroup.soupsAndBroths: 2
    };

    for (int day = 0; day < 7; day++) {
      String dayOfWeek = _getDayOfWeek(day);

      Dish morningDish = _selectDishWithGroupFrequency(
        (availableMorningDishes?.isNotEmpty ?? false)
            ? availableMorningDishes!
            : otherMorningDishes,
        proteinLeft,
        fatsLeft,
        carbsLeft,
        caloriesLeft,
        day,
        selectedDishes,
        groupFrequency,
      );

      proteinLeft -= morningDish.protein;
      fatsLeft -= morningDish.fats;
      carbsLeft -= morningDish.carbs;
      caloriesLeft -= morningDish.calories;

      Dish lunchDish;

      if (day == 0) {
        lunchDish = _selectDishWithGroupFrequency(
          (availableLunchDishes?.isNotEmpty ?? false)
              ? availableLunchDishes!
              : otherLunchDishes,
          proteinLeft,
          fatsLeft,
          carbsLeft,
          caloriesLeft,
          day,
          selectedDishes,
          groupFrequency,
        );
      } else {
        if (weekRation.elementAtOrNull(day) != null) {
          lunchDish = weekRation[day].lunchDish!;
        } else {
          lunchDish = _selectDishWithGroupFrequency(
            (availableLunchDishes?.isNotEmpty ?? false)
                ? availableLunchDishes!
                : otherLunchDishes,
            proteinLeft,
            fatsLeft,
            carbsLeft,
            caloriesLeft,
            day,
            selectedDishes,
            groupFrequency,
          );
        }
      }

      proteinLeft -= lunchDish.protein;
      fatsLeft -= lunchDish.fats;
      carbsLeft -= lunchDish.carbs;
      caloriesLeft -= lunchDish.calories;

      Dish snackDish = _selectDishWithGroupFrequency(
        (availableSnackDishes?.isNotEmpty ?? false)
            ? availableSnackDishes!
            : otherSnackDishes,
        proteinLeft,
        fatsLeft,
        carbsLeft,
        caloriesLeft,
        day,
        selectedDishes,
        groupFrequency,
      );

      proteinLeft -= snackDish.protein;
      fatsLeft -= snackDish.fats;
      carbsLeft -= snackDish.carbs;
      caloriesLeft -= snackDish.calories;

      Dish dinnerDish = _selectDishWithGroupFrequency(
        (availableDinnerDishes?.isNotEmpty ?? false)
            ? availableDinnerDishes!
            : otherDinnerDishes,
        proteinLeft,
        fatsLeft,
        carbsLeft,
        caloriesLeft,
        day,
        selectedDishes,
        groupFrequency,
      );

      proteinLeft -= dinnerDish.protein;
      fatsLeft -= dinnerDish.fats;
      carbsLeft -= dinnerDish.carbs;
      caloriesLeft -= dinnerDish.calories;

      if (weekRation.elementAtOrNull(day) != null) {
        weekRation[day] = weekRation[day].copyWith(
            day: dayOfWeek,
            dayIndex: day,
            morningDish: morningDish,
            snackDish: snackDish,
            dinnerDish: dinnerDish,
            totalCcal: dinnerDish.calories +
                snackDish.calories +
                lunchDish.calories +
                morningDish.calories);
      } else {
        weekRation.add(DayRation(
            day: dayOfWeek,
            dayIndex: day,
            morningDish: morningDish,
            lunchDish: lunchDish,
            snackDish: snackDish,
            dinnerDish: dinnerDish,
            totalCcal: dinnerDish.calories +
                snackDish.calories +
                lunchDish.calories +
                morningDish.calories));
        _handleSoupDish(day, weekRation, lunchDish);
      }
    }

    return weekRation;
  }

  DayRation generateDayRation(
    List<Dish>? availableMorningDishes,
    List<Dish>? availableLunchDishes,
    List<Dish>? availableSnackDishes,
    List<Dish>? availableDinnerDishes,
    List<Dish> otherMorningDishes,
    List<Dish> otherLunchDishes,
    List<Dish> otherSnackDishes,
    List<Dish> otherDinnerDishes,
    String day,
    int dayIndex,
    Human person,
  ) {
    final pfc = person.calculateWeeklyMacronutrients();
    final ccals = person.calculateWeeklyCalories();
    double proteinLeft = pfc['protein']!;
    double fatsLeft = pfc['fats']!;
    double carbsLeft = pfc['carbs']!;
    double caloriesLeft = ccals;

    Dish morningDish = _selectDish(
      (availableMorningDishes?.isNotEmpty ?? false)
          ? availableMorningDishes!
          : otherMorningDishes,
      proteinLeft,
      fatsLeft,
      carbsLeft,
      caloriesLeft,
    );
    proteinLeft -= morningDish.protein;
    fatsLeft -= morningDish.fats;
    carbsLeft -= morningDish.carbs;
    caloriesLeft -= morningDish.calories;

    Dish lunchDish = _selectDish(
      (availableLunchDishes?.isNotEmpty ?? false)
          ? availableLunchDishes!
          : otherLunchDishes,
      proteinLeft,
      fatsLeft,
      carbsLeft,
      caloriesLeft,
    );
    proteinLeft -= lunchDish.protein;
    fatsLeft -= lunchDish.fats;
    carbsLeft -= lunchDish.carbs;
    caloriesLeft -= lunchDish.calories;

    Dish snackDish = _selectDish(
      (availableSnackDishes?.isNotEmpty ?? false)
          ? availableSnackDishes!
          : otherSnackDishes,
      proteinLeft,
      fatsLeft,
      carbsLeft,
      caloriesLeft,
    );
    proteinLeft -= snackDish.protein;
    fatsLeft -= snackDish.fats;
    carbsLeft -= snackDish.carbs;
    caloriesLeft -= snackDish.calories;

    Dish dinnerDish = _selectDish(
      (availableDinnerDishes?.isNotEmpty ?? false)
          ? availableDinnerDishes!
          : otherDinnerDishes,
      proteinLeft,
      fatsLeft,
      carbsLeft,
      caloriesLeft,
    );
    proteinLeft -= dinnerDish.protein;
    fatsLeft -= dinnerDish.fats;
    carbsLeft -= dinnerDish.carbs;
    caloriesLeft -= dinnerDish.calories;

    return DayRation(
        day: day,
        dayIndex: dayIndex,
        morningDish: morningDish,
        lunchDish: lunchDish,
        snackDish: snackDish,
        dinnerDish: dinnerDish,
        totalCcal: dinnerDish.calories +
            snackDish.calories +
            lunchDish.calories +
            morningDish.calories);
  }

  List<Dish> findAvailableDishes(
    List<Product> availableProducts,
    List<Dish> possibleDishes,
    Set<String>? restrictions,
  ) {
    List<Dish> availableDishes = [];

    for (final dish in possibleDishes) {
      if (restrictions != null) {
        if (dish.restrictions.intersection(restrictions).isNotEmpty) {
          continue;
        }
      }

      final checkedDish = checkAvailableProducts(dish, availableProducts);
      bool allProductsAvailable = dish.products.every((product) {
        return availableProducts
            .any((availableProduct) => availableProduct.title == product.title);
      });

      if (allProductsAvailable) {
        availableDishes.add(dish);
      } else if (checkedDish.missingProducts.isNotEmpty) {
        availableDishes.add(checkedDish);
      } else {
        continue;
      }
    }

    return availableDishes;
  }

  Dish checkAvailableProducts(
      Dish currentDish, List<Product> availableProducts) {
    int availabilityRate = 0;
    int costNeeded = 0;
    List<Product> productsNeeded = [];

    for (final product in currentDish.products) {
      if (availableProducts.contains(product)) {
        availabilityRate += 1;
      } else {
        productsNeeded.add(product);
        costNeeded += product.price;
      }
    }

    double availabilityPercentage =
        availabilityRate / currentDish.products.length;

    if (availabilityPercentage >= 0.6) {
      return currentDish.copyWith(
        totalMissingCost: costNeeded,
        missingProducts: productsNeeded,
      );
    } else {
      return currentDish;
    }
  }

  Dish _selectDishWithGroupFrequency(
    final List<Dish> dishes,
    double proteinLeft,
    double fatsLeft,
    double carbsLeft,
    double caloriesLeft,
    int currentDay,
    final Map<Dish, int> selectedDayDishes,
    final Map<ProductGroup, int> groupFrequency,
  ) {
    Dish selectedDish;

    while (true) {
      selectedDish = dishes[Random().nextInt(dishes.length)];
      final lastAddedDay = selectedDayDishes[selectedDish] ?? -100;

      if (selectedDayDishes.containsKey(selectedDish) &&
          (currentDay - lastAddedDay) < 3) {
        continue;
      }

      groupFrequency[selectedDish.generalProductGroup] =
          groupFrequency[selectedDish.generalProductGroup]! - 1;

      proteinLeft -= selectedDish.protein;
      fatsLeft -= selectedDish.fats;
      carbsLeft -= selectedDish.carbs;
      caloriesLeft -= selectedDish.calories;

      if (selectedDish.generalProductGroup == ProductGroup.soupsAndBroths) {
        selectedDayDishes[selectedDish] = currentDay + 3;
      } else {
        selectedDayDishes[selectedDish] = currentDay;
      }
      break;
    }

    return selectedDish;
  }

  Dish _selectDish(List<Dish> dishes, double proteinLeft, double fatsLeft,
      double carbsLeft, double caloriesLeft) {
    if (dishes.isEmpty) return dishes[0];

    dishes.sort((a, b) {
      double aDiff = (a.protein - proteinLeft).abs() +
          (a.fats - fatsLeft).abs() +
          (a.carbs - carbsLeft).abs() +
          (a.calories - caloriesLeft).abs();
      double bDiff = (b.protein - proteinLeft).abs() +
          (b.fats - fatsLeft).abs() +
          (b.carbs - carbsLeft).abs() +
          (b.calories - caloriesLeft).abs();
      return aDiff.compareTo(bDiff);
    });

    int randomIndex = Random().nextInt(dishes.length);
    return dishes[randomIndex];
  }

  void _handleSoupDish(
    int day,
    List<DayRation> weekRation,
    Dish lunchDish,
  ) {
    if (lunchDish.generalProductGroup == ProductGroup.soupsAndBroths) {
      int daysToFill = 0;

      if (day + 1 < 7 && weekRation.length <= day + 1) {
        daysToFill += 1;
      }

      if (day + 2 < 7 && weekRation.length <= day + 2) {
        daysToFill += 1;
      }

      if (daysToFill > 0) {
        for (int i = 0; i < daysToFill; i++) {
          int targetDay = day + i + 1;
          if (targetDay < 7 && weekRation.length <= targetDay) {
            weekRation.insert(
              targetDay,
              DayRation(
                day: null,
                dayIndex: null,
                morningDish: null,
                lunchDish: lunchDish,
                snackDish: null,
                dinnerDish: null,
                totalCcal: null,
              ),
            );
          }
        }
      }
    }
  }

  String _getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case 0:
        return 'Понедельник';
      case 1:
        return 'Вторник';
      case 2:
        return 'Среда';
      case 3:
        return 'Четверг';
      case 4:
        return 'Пятница';
      case 5:
        return 'Суббота';
      case 6:
        return 'Воскресенье';
      default:
        return 'Неизвестный день';
    }
  }
}
