import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/graph_widget.dart';
import 'package:naturly/src/feature/home/widget/nutrients_widget.dart';

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
            NutrientWidget(
              title: 'Жиры',
              subtitle: 'гр',
              nutrient: 12,
              nutrientDaily: 33,
            ),
            SizedBox(width: 10),
            NutrientWidget(
              title: 'Белки',
              subtitle: 'гр',
              nutrient: 1,
              nutrientDaily: 22,
            ),
            SizedBox(width: 10),

            NutrientWidget(
              title: 'Углеводы',
              subtitle: 'гр',
              nutrient: 5,
              nutrientDaily: 52,
            ),
            SizedBox(width: 10),

            NutrientWidget(
              title: 'Калории',
              subtitle: 'ккал',
              nutrient: 1283,
              nutrientDaily: 2200,
            ),
          ],
        ),
        SizedBox(height: 20),
        GraphWidget(),
      ],
    );
  }
}
