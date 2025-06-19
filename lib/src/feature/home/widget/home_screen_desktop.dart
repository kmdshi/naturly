import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/graph_widget.dart';
import 'package:naturly/src/feature/home/widget/nutrients_info_widget.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({super.key});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            NutrientsWidget(
              caloriesGoal: 12,
              eatenCalories: 2,
              proteinGoal: 2,
              proteinEaten: 3,
              fatsGoal: 3,
              fatsEaten: 4,
              carbsGoal: 5,
              carbsEaten: 5,
            ),
          ],
        ),
        SizedBox(height: 20),
        CaloriesGraphWidget(),
      ],
    );
  }
}
