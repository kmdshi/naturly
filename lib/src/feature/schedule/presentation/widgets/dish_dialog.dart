// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';

import 'package:naturly/src/core/common/models/dish_model.dart';
import 'package:naturly/src/core/common/services/food_service.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';

class DishDialog extends StatefulWidget {
  final Dish? dish;
  final List<DayRation> schedule;
  final String mealType;
  final int dayIndex;
  const DishDialog({
    super.key,
    required this.dish,
    required this.mealType,
    required this.schedule,
    required this.dayIndex,
  });

  @override
  State<DishDialog> createState() => _DishDialogState();
}

class _DishDialogState extends State<DishDialog> {
  late Dish? currentDish;

  @override
  void initState() {
    super.initState();
    currentDish = widget.dish;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(currentDish?.title ?? 'Блюдо не выбрано'),
        Text('Тип приёма пищи: ${widget.mealType}'),
        const SizedBox(height: 8),
        Text('Калории: ${currentDish?.calories ?? 0}'),
        Text('Белки: ${currentDish?.protein ?? 0} г'),
        Text('Жиры: ${currentDish?.fats ?? 0} г'),
        Text('Углеводы: ${currentDish?.carbs ?? 0} г'),
        const SizedBox(height: 8),
        Text('Ограничения: ${currentDish?.restrictions.join(", ") ?? "—"}'),
        const SizedBox(height: 8),
        Text('Цена: ${currentDish?.totalPrice ?? 0}₽'),
        if (currentDish?.totalMissingCost != null)
          Text(
            'Не хватает продуктов на сумму: ${currentDish!.totalMissingCost}₽',
          ),

        const SizedBox(height: 8),

        Text('Продукты:', style: TextStyle(fontWeight: FontWeight.bold)),
        if ((currentDish?.products ?? []).isNotEmpty)
          ...currentDish!.products.map((p) => Text('- ${p.title}'))
        else
          Text('-'),

        const SizedBox(height: 8),

        if ((currentDish?.missingProducts ?? []).isNotEmpty) ...[
          Text(
            'Отсутствующие продукты:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...currentDish!.missingProducts.map((p) => Text('- ${p.title}')),
        ],

        const SizedBox(height: 8),

        Text('Группа: ${currentDish?.generalProductGroup.name ?? "—"}'),

        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeDataAlertScreen(
                          dish: widget.dish,
                          mealType: widget.mealType,
                          schedule: widget.schedule,
                          dayIndex: widget.dayIndex,
                        ),
                  ),
                );
              },
              child: Text('Изменить данные'),
            ),
            Spacer(),
            ElevatedButton(onPressed: deleteMeal, child: Text('Удалить')),
          ],
        ),
      ],
    );
  }

  void deleteMeal() {
    final ration = [...widget.schedule];
    final currentDay = ration[widget.dayIndex];

    Dish? morning =
        widget.mealType == 'Завтрак' ? null : currentDay.morningDish;
    Dish? lunch = widget.mealType == 'Обед' ? null : currentDay.lunchDish;
    Dish? snack = widget.mealType == 'Перекус' ? null : currentDay.snackDish;
    Dish? dinner = widget.mealType == 'Ужин' ? null : currentDay.dinnerDish;

    final updatedDay = DayRation(
      day: currentDay.day,
      dayIndex: currentDay.dayIndex,
      morningDish: morning,
      lunchDish: lunch,
      snackDish: snack,
      dinnerDish: dinner,
    );

    final updatedDayWithCalories = updatedDay.copyWith(
      totalCcal: FoodService().recalculateCalories(updatedDay),
    );
    // TODO: сделать рекалькулейт в DayRation
    ration[widget.dayIndex] = updatedDayWithCalories;

    context.read<ScheduleBloc>().add(ScheduleSaveUserRation(ration: ration));
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class ChangeDataAlertScreen extends StatefulWidget {
  final Dish? dish;
  final String mealType;
  final List<DayRation> schedule;
  final int dayIndex;

  const ChangeDataAlertScreen({
    required this.dish,
    required this.mealType,
    required this.schedule,
    required this.dayIndex,
  });

  @override
  State<ChangeDataAlertScreen> createState() => _ChangeDataAlertScreenState();
}

class _ChangeDataAlertScreenState extends State<ChangeDataAlertScreen> {
  @override
  void initState() {
    context.read<UserbaseBloc>().add(UserbaseGetDishesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserbaseBloc, UserbaseState>(
      builder: (context, state) {
        if (state is UserbaseLoaded) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Контент 1'),
                ...state.dishes.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ExpansionTile(
                      expandedAlignment: Alignment.centerLeft,
                      title: Text(e.title),
                      children: [
                        Text('- Protein: ${e.protein} г'),
                        Text('- Carbs: ${e.carbs} г'),
                        Text('- Fats: ${e.fats} г'),
                        Text('- Calories: ${e.calories} ккал / 100 g'),
                        Text('- Price: ${e.totalPrice} ₽'),
                        ElevatedButton(
                          onPressed: () => changeMeal(e),
                          child: Text('Выбрать'),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(onPressed: backPush, child: Text('Обратно')),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  void changeMeal(final Dish newDish) {
    final ration = [...widget.schedule];
    final currentDay = ration[widget.dayIndex];

    Dish? morning =
        widget.mealType == 'Завтрак' ? newDish : currentDay.morningDish;
    Dish? lunch = widget.mealType == 'Обед' ? newDish : currentDay.lunchDish;
    Dish? snack = widget.mealType == 'Перекус' ? newDish : currentDay.snackDish;
    Dish? dinner = widget.mealType == 'Ужин' ? newDish : currentDay.dinnerDish;

    final updatedDay = currentDay.copyWith(
      morningDish: morning,
      lunchDish: lunch,
      snackDish: snack,
      dinnerDish: dinner,
    );

    final updatedDayWithCalories = updatedDay.copyWith(
      totalCcal: FoodService().recalculateCalories(updatedDay),
    );

    ration[widget.dayIndex] = updatedDayWithCalories;

    context.read<ScheduleBloc>().add(ScheduleSaveUserRation(ration: ration));
    Navigator.of(context, rootNavigator: true).pop();
  }

  void backPush() => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder:
          (context) => DishDialog(
            dish: widget.dish,
            mealType: widget.mealType,
            schedule: widget.schedule,
            dayIndex: widget.dayIndex,
          ),
    ),
    (route) => false,
  );
}
