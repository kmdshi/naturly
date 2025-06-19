import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/graph_widget.dart';
import 'package:naturly/src/feature/home/widget/nutrients_info_widget.dart';
import 'package:naturly/src/feature/home/widget/today_meal_plan_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  late final PageController _pageController;
  Color? dominantColor;

  @override
  void initState() {
    _pageController = PageController();
    updatePalette();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: dominantColor ?? Color(0xFFB3A89D),
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    foregroundImage: AssetImage('assets/images/aa.jpg'),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Bob',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF432912),
                      ),
                    ),
                    Text(
                      'Monday,  December 9',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Color(0xFF432912).withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Column(
              children: [
                SizedBox(
                  height: 450,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      NutrientsWidget(
                        caloriesGoal: 2000,
                        eatenCalories: 1300,
                        proteinGoal: 100,
                        proteinEaten: 60,
                        fatsGoal: 60,
                        fatsEaten: 40,
                        carbsGoal: 200,
                        carbsEaten: 150,
                      ),
                      CaloriesGraphWidget(),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Color(0xFF432912),
                    dotColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            TodayMealPlanWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> updatePalette() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
      AssetImage('assets/images/aa.jpg'),
    );

    setState(() {
      dominantColor = generator.dominantColor?.color ?? Colors.grey;
    });
  }
}
