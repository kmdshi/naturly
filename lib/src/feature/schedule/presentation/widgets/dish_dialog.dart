// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:naturly/src/core/common/models/dish_model.dart';

class DishDialog extends StatefulWidget {
  final Dish dish;

  const DishDialog({super.key, required this.dish});

  @override
  State<DishDialog> createState() => _DishDialogState();
}

class _DishDialogState extends State<DishDialog> {
  late Dish currentDish;

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
        Text(currentDish.title),
        Text('Тип приёма пищи: ${currentDish.mealType}'),
        const SizedBox(height: 8),
        Text('Калории: ${currentDish.calories}'),
        Text('Белки: ${currentDish.protein} г'),
        Text('Жиры: ${currentDish.fats} г'),
        Text('Углеводы: ${currentDish.carbs} г'),
        const SizedBox(height: 8),
        Text('Ограничения: ${currentDish.restrictions.join(", ")}'),
        const SizedBox(height: 8),
        Text('Цена: ${currentDish.totalPrice}₽'),
        if (currentDish.totalMissingCost != null)
          Text(
            'Не хватает продуктов на сумму: ${currentDish.totalMissingCost}₽',
          ),
        const SizedBox(height: 8),
        Text('Продукты:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...currentDish.products.map((p) => Text('- ${p.title}')),
        const SizedBox(height: 8),
        if (currentDish.missingProducts.isNotEmpty) ...[
          Text(
            'Отсутствующие продукты:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...currentDish.missingProducts.map((p) => Text('- ${p.title}')),
        ],
        const SizedBox(height: 8),
        Text('Группа: ${currentDish.generalProductGroup.name}'),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ChangeDataAlertScreen(dish: widget.dish),
                  ),
                );
              },
              child: Text('Изменить данные'),
            ),
            Spacer(),
            ElevatedButton(onPressed: () {}, child: Text('Удалить')),
          ],
        ),
      ],
    );
  }
}

class ChangeDataAlertScreen extends StatelessWidget {
  final Dish dish;

  const ChangeDataAlertScreen({required this.dish});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Контент 1'),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DishDialog(dish: dish)),
              (route) => false,
            );
          },
          child: Text('Обратно'),
        ),
      ],
    );
  }
}


