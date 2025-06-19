import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/meal_card_widget.dart';

class TodayMealPlanWidget extends StatefulWidget {
  const TodayMealPlanWidget({super.key});

  @override
  State<TodayMealPlanWidget> createState() => _TodayMealPlanWidgetState();
}

class _TodayMealPlanWidgetState extends State<TodayMealPlanWidget> {
  int selectedIndex = 0;

  final List<String> tabs = ['Завтрак', 'Обед', 'Перекус', 'Ужин'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Meal Plan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() => selectedIndex = index);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF432912) : Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 20),

        Builder(
          builder: (_) {
            switch (selectedIndex) {
              case 0:
                return MealCardWidget();
              case 1:
                return MealCardWidget();
              case 2:
                return MealCardWidget();
              default:
                return SizedBox();
            }
          },
        ),
      ],
    );
  }
}
