import 'dart:math';

import 'package:collection/collection.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/models/food_enums.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/core/common/models/product_model.dart';

class FoodService {
  List<DayRation> generateWeekRation(
    List<Product> availableProducts,
    List<Dish> morningDishes,
    List<Dish> lunchDishes,
    List<Dish> snackDishes,
    List<Dish> dinnerDishes,
    Human person,
  ) {
    final pfc = person.calculateWeeklyMacronutrients();
    final ccals = person.calculateWeeklyCalories();
    double proteinLeft = pfc['protein']!;
    double fatsLeft = pfc['fats']!;
    double carbsLeft = pfc['carbs']!;
    double caloriesLeft = ccals;

    List<DayRation> weekRation = [];
    Map<String, int> selectedDishes = {};
    var copyAvilableProducts = List<Product>.from(availableProducts);

    Map<ProductGroup, int> groupFrequency = {
      ProductGroup.grainsAndPotatoes: 4,
      ProductGroup.vegetablesFruitsAndBerries: 5,
      ProductGroup.dairyAndDairyProducts: 3,
      ProductGroup.fishPoultryMeatAndEggs: 5,
      ProductGroup.addedFatsNutsSeedsAndOilyFruits: 3,
      ProductGroup.sugarSweetsAndSnacks: 2,
      ProductGroup.soupsAndBroths: 2,
    };

    for (int day = 0; day < 7; day++) {
      DateTime dayDate = DateTime.now().add(Duration(days: day));

      final availableMorningDishes = findAvailableDishes(
        copyAvilableProducts,
        morningDishes,
        {"Глютен"},
      );
      final availableLunchdishes = findAvailableDishes(
        copyAvilableProducts,
        lunchDishes,
        null,
      );
      final availableSnackishes = findAvailableDishes(
        copyAvilableProducts,
        snackDishes,
        null,
      );
      final availableDinnerDishes = findAvailableDishes(
        copyAvilableProducts,
        dinnerDishes,
        null,
      );

      Dish? morningDish =
          morningDishes.isNotEmpty
              ? _selectDishWithGroupFrequency(
                [...availableMorningDishes, ...morningDishes],
                proteinLeft,
                fatsLeft,
                carbsLeft,
                caloriesLeft,
                day,
                selectedDishes,
                groupFrequency,
              )
              : null;

      proteinLeft -= morningDish?.protein ?? 0;
      fatsLeft -= morningDish?.fats ?? 0;
      carbsLeft -= morningDish?.carbs ?? 0;
      caloriesLeft -= morningDish?.calories ?? 0;
      copyAvilableProducts = _updateAvailableProducts(
        morningDish,
        copyAvilableProducts,
      );

      Dish? lunchDish;

      if (day == 0) {
        lunchDish =
            lunchDishes.isNotEmpty
                ? _selectDishWithGroupFrequency(
                  [...availableLunchdishes, ...lunchDishes],
                  proteinLeft,
                  fatsLeft,
                  carbsLeft,
                  caloriesLeft,
                  day,
                  selectedDishes,
                  groupFrequency,
                )
                : null;
        copyAvilableProducts = _updateAvailableProducts(
          lunchDish,
          copyAvilableProducts,
        );
      } else {
        if (weekRation.elementAtOrNull(day) != null) {
          lunchDish = weekRation[day].lunchDish!;
        } else {
          lunchDish =
              lunchDishes.isNotEmpty
                  ? _selectDishWithGroupFrequency(
                    [...availableLunchdishes, ...lunchDishes],
                    proteinLeft,
                    fatsLeft,
                    carbsLeft,
                    caloriesLeft,
                    day,
                    selectedDishes,
                    groupFrequency,
                  )
                  : null;
        }
      }

      proteinLeft -= lunchDish?.protein ?? 0;
      fatsLeft -= lunchDish?.fats ?? 0;
      carbsLeft -= lunchDish?.carbs ?? 0;
      caloriesLeft -= lunchDish?.calories ?? 0;
      copyAvilableProducts = _updateAvailableProducts(
        lunchDish,
        copyAvilableProducts,
      );

      Dish? snackDish =
          snackDishes.isNotEmpty
              ? _selectDishWithGroupFrequency(
                [...availableSnackishes, ...snackDishes],
                proteinLeft,
                fatsLeft,
                carbsLeft,
                caloriesLeft,
                day,
                selectedDishes,
                groupFrequency,
              )
              : null;

      proteinLeft -= snackDish?.protein ?? 0;
      fatsLeft -= snackDish?.fats ?? 0;
      carbsLeft -= snackDish?.carbs ?? 0;
      caloriesLeft -= snackDish?.calories ?? 0;
      copyAvilableProducts = _updateAvailableProducts(
        snackDish,
        copyAvilableProducts,
      );

      Dish? dinnerDish =
          dinnerDishes.isNotEmpty
              ? _selectDishWithGroupFrequency(
                [...availableDinnerDishes, ...dinnerDishes],
                proteinLeft,
                fatsLeft,
                carbsLeft,
                caloriesLeft,
                day,
                selectedDishes,
                groupFrequency,
              )
              : null;

      proteinLeft -= dinnerDish?.protein ?? 0;
      fatsLeft -= dinnerDish?.fats ?? 0;
      carbsLeft -= dinnerDish?.carbs ?? 0;
      caloriesLeft -= dinnerDish?.calories ?? 0;
      copyAvilableProducts = _updateAvailableProducts(
        dinnerDish,
        copyAvilableProducts,
      );

      if (weekRation.elementAtOrNull(day) != null) {
        weekRation[day] = weekRation[day].copyWith(
          day: dayDate,
          dayIndex: day,
          morningDish: morningDish,
          snackDish: snackDish,
          dinnerDish: dinnerDish,
          totalCcal:
              (dinnerDish?.calories ?? 0) +
              (snackDish?.calories ?? 0) +
              (lunchDish?.calories ?? 0) +
              (morningDish?.calories ?? 0),
        );
      } else {
        weekRation.add(
          DayRation(
            day: dayDate,
            dayIndex: day,
            morningDish: morningDish,
            lunchDish: lunchDish,
            snackDish: snackDish,
            dinnerDish: dinnerDish,
            totalCcal:
                (dinnerDish?.calories ?? 0) +
                (snackDish?.calories ?? 0) +
                (lunchDish?.calories ?? 0) +
                (morningDish?.calories ?? 0),
          ),
        );
        _handleSoupDish(day, weekRation, lunchDish);
      }
    }

    return weekRation;
  }

  DayRation generateDayRation(
    List<Product> availableProducts,
    List<Dish> morningDishes,
    List<Dish> lunchDishes,
    List<Dish> snackDishes,
    List<Dish> dinnerDishes,
    String day,
    int dayIndex,
    Human person,
  ) {
    final pfc = person.calculateDayMacronutrients();
    final ccals = person.calculateDayCalories();
    var copyAvilableProducts = List<Product>.from(availableProducts);
    DateTime dayDate = DateTime.now();

    double proteinLeft = pfc['protein']!;
    double fatsLeft = pfc['fats']!;
    double carbsLeft = pfc['carbs']!;
    double caloriesLeft = ccals;

    final availableMorningDishes = findAvailableDishes(
      copyAvilableProducts,
      morningDishes,
      {"Глютен"},
    );
    final availableLunchdishes = findAvailableDishes(
      copyAvilableProducts,
      lunchDishes,
      null,
    );
    final availableSnackishes = findAvailableDishes(
      copyAvilableProducts,
      snackDishes,
      null,
    );
    final availableDinnerDishes = findAvailableDishes(
      copyAvilableProducts,
      dinnerDishes,
      null,
    );

    Dish? morningDish =
        morningDishes.isNotEmpty
            ? _selectDish(
              [...availableMorningDishes, ...morningDishes],
              proteinLeft,
              fatsLeft,
              carbsLeft,
              caloriesLeft,
            )
            : null;

    proteinLeft -= morningDish?.protein ?? 0;
    fatsLeft -= morningDish?.fats ?? 0;
    carbsLeft -= morningDish?.carbs ?? 0;
    caloriesLeft -= morningDish?.calories ?? 0;
    copyAvilableProducts = _updateAvailableProducts(
      morningDish,
      copyAvilableProducts,
    );

    Dish? lunchDish =
        lunchDishes.isNotEmpty
            ? _selectDish(
              [...availableLunchdishes, ...lunchDishes],
              proteinLeft,
              fatsLeft,
              carbsLeft,
              caloriesLeft,
            )
            : null;

    proteinLeft -= lunchDish?.protein ?? 0;
    fatsLeft -= lunchDish?.fats ?? 0;
    carbsLeft -= lunchDish?.carbs ?? 0;
    caloriesLeft -= lunchDish?.calories ?? 0;
    copyAvilableProducts = _updateAvailableProducts(
      lunchDish,
      copyAvilableProducts,
    );

    Dish? snackDish =
        snackDishes.isNotEmpty
            ? _selectDish(
              [...availableSnackishes, ...snackDishes],
              proteinLeft,
              fatsLeft,
              carbsLeft,
              caloriesLeft,
            )
            : null;

    proteinLeft -= snackDish?.protein ?? 0;
    fatsLeft -= snackDish?.fats ?? 0;
    carbsLeft -= snackDish?.carbs ?? 0;
    caloriesLeft -= snackDish?.calories ?? 0;
    copyAvilableProducts = _updateAvailableProducts(
      snackDish,
      copyAvilableProducts,
    );

    Dish? dinnerDish =
        dinnerDishes.isNotEmpty
            ? _selectDish(
              [...availableDinnerDishes, ...dinnerDishes],
              proteinLeft,
              fatsLeft,
              carbsLeft,
              caloriesLeft,
            )
            : null;

    proteinLeft -= dinnerDish?.protein ?? 0;
    fatsLeft -= dinnerDish?.fats ?? 0;
    carbsLeft -= dinnerDish?.carbs ?? 0;
    caloriesLeft -= dinnerDish?.calories ?? 0;
    copyAvilableProducts = _updateAvailableProducts(
      dinnerDish,
      copyAvilableProducts,
    );

    return DayRation(
      day: dayDate,
      dayIndex: dayIndex,
      morningDish: morningDish,
      lunchDish: lunchDish,
      snackDish: snackDish,
      dinnerDish: dinnerDish,
      totalCcal:
          (dinnerDish?.calories ?? 0) +
          (snackDish?.calories ?? 0) +
          (lunchDish?.calories ?? 0) +
          (morningDish?.calories ?? 0),
    );
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
        return availableProducts.any((availableProduct) {
          return availableProduct.title == product.title &&
              availableProduct.quantity <= product.quantity;
        });
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
    Dish currentDish,
    List<Product> availableProducts,
  ) {
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
        //  missingProducts: productsNeeded,
        missingProducts: [],
      );
    } else {
      return currentDish.copyWith(
        totalMissingCost: currentDish.totalPrice,
        // missingProducts: currentDish.products,
        missingProducts: [],
      );
    }
  }

  Dish _selectDishWithGroupFrequency(
    final List<Dish> dishes,
    double proteinLeft,
    double fatsLeft,
    double carbsLeft,
    double caloriesLeft,
    int currentDay,
    final Map<String, int> selectedDayDishes,
    final Map<ProductGroup, int> groupFrequency,
  ) {
    Dish selectedDish;

    while (true) {
      selectedDish = dishes[Random().nextInt(dishes.length)];
      final lastAddedDay = selectedDayDishes[selectedDish.title] ?? -100;

      // TODO: ПОФИКСИТЬ БАГ С бесконечным лупом если < 3 блюд чтобы на цикл не уходило
      if (selectedDayDishes.containsKey(selectedDish.title) &&
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
        selectedDayDishes[selectedDish.title] = currentDay + 3;
      } else {
        selectedDayDishes[selectedDish.title] = currentDay;
      }
      break;
    }

    return selectedDish;
  }

  DayRation editDayRation(Dish newDish, DayRation currentDayRation) {
    final now = DateTime.now();

    Dish? currentMeal;
    String? mealType;

    if (now.hour < 11) {
      currentMeal = currentDayRation.morningDish;
      mealType = 'morning';
    } else if (now.hour < 16) {
      currentMeal = currentDayRation.lunchDish;
      mealType = 'lunch';
    } else if (now.hour < 18) {
      currentMeal = currentDayRation.snackDish;
      mealType = 'snack';
    } else if (now.hour < 20) {
      currentMeal = currentDayRation.dinnerDish;
      mealType = 'dinner';
    } else {
      return currentDayRation;
    }

    if ((currentMeal?.calories ?? 0) >= newDish.calories) {
      switch (mealType) {
        case 'morning':
          return currentDayRation.copyWith(morningDish: newDish);
        case 'lunch':
          return currentDayRation.copyWith(lunchDish: newDish);
        case 'snack':
          return currentDayRation.copyWith(snackDish: newDish);
        case 'dinner':
          return currentDayRation.copyWith(dinnerDish: newDish);
        default:
          return currentDayRation;
      }
    } else {
      return _overCalloriesGenerateDayRation(
        mealType,
        currentDayRation,
        newDish,
      );
    }
  }

  DayRation _overCalloriesGenerateDayRation(
    String mealType,
    DayRation currentDayRation,
    Dish newDish,
  ) {
    final meals = {
      'morning': currentDayRation.morningDish,
      'lunch': currentDayRation.lunchDish,
      'snack': currentDayRation.snackDish,
      'dinner': currentDayRation.dinnerDish,
    };

    final mealOrder = ['morning', 'lunch', 'snack', 'dinner'];
    final startIndex = mealOrder.indexOf(mealType);
    final futureMeals = mealOrder.sublist(startIndex + 1);

    int sum = 0;
    final mealsToNullify = <String>[];

    for (final meal in futureMeals) {
      sum += meals[meal]?.calories ?? 0;
      if (newDish.calories > sum) {
        mealsToNullify.add(meal);
      } else {
        break;
      }
    }

    return currentDayRation.copyWith(
      morningDish: mealType == 'morning' ? newDish : meals['morning'],
      lunchDish:
          mealType == 'lunch'
              ? newDish
              : (mealsToNullify.contains('lunch') ? null : meals['lunch']),
      snackDish:
          mealType == 'snack'
              ? newDish
              : (mealsToNullify.contains('snack') ? null : meals['snack']),
      dinnerDish:
          mealType == 'dinner'
              ? newDish
              : (mealsToNullify.contains('dinner') ? null : meals['dinner']),
    );
  }

  Dish _selectDish(
    List<Dish> dishes,
    double proteinLeft,
    double fatsLeft,
    double carbsLeft,
    double caloriesLeft,
  ) {
    if (dishes.isEmpty) return dishes[0];

    dishes.sort((a, b) {
      double aDiff =
          (a.protein - proteinLeft).abs() +
          (a.fats - fatsLeft).abs() +
          (a.carbs - carbsLeft).abs() +
          (a.calories - caloriesLeft).abs();
      double bDiff =
          (b.protein - proteinLeft).abs() +
          (b.fats - fatsLeft).abs() +
          (b.carbs - carbsLeft).abs() +
          (b.calories - caloriesLeft).abs();
      return aDiff.compareTo(bDiff);
    });

    int randomIndex = Random().nextInt(dishes.length);
    return dishes[randomIndex];
  }

  List<Product> _updateAvailableProducts(
    Dish? dish,
    List<Product> availableProducts,
  ) {
    if (dish != null && dish.missingProducts.isNotEmpty) {
      for (final product in dish.products) {
        final availableProduct = availableProducts.firstWhereOrNull(
          (element) => element.title == product.title,
        );

        if (availableProduct != null &&
            availableProduct.quantity >= product.quantity) {
          final updatedProduct = availableProduct.copyWith(
            quantity: availableProduct.quantity - product.quantity,
          );

          availableProducts =
              availableProducts.map((p) {
                return p.title == availableProduct.title ? updatedProduct : p;
              }).toList();
        }
      }
    }

    return availableProducts;
  }

  void _handleSoupDish(int day, List<DayRation> weekRation, Dish? lunchDish) {
    if (lunchDish != null &&
        lunchDish.generalProductGroup == ProductGroup.soupsAndBroths) {
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

  int recalculateCalories(DayRation day) {
    final morning = day.morningDish?.calories ?? 0;
    final lunch = day.lunchDish?.calories ?? 0;
    final snack = day.snackDish?.calories ?? 0;
    final dinner = day.dinnerDish?.calories ?? 0;

    return morning + lunch + snack + dinner;
  }
}
