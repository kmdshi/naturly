import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/graph_widget.dart';
import 'package:naturly/src/feature/home/widget/nutrients_widget.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  foregroundImage: AssetImage('assets/images/aa.jpg'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Привет боб',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Снова ты тут)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 110,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Color(0xFFECEEF6).withValues(alpha: 0.3),
                  width: 1.6,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ваш след.прием пищи',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('- Гречка с яйцом мамонта 2/5'),
                      ],
                    ),
                  ),
                  Divider(color: Color(0xFFECEEF6), thickness: 1, height: 1),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              print('Уже съел');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: const Text(
                                'Уже съел',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                          width: 1,
                          color: Color(0xFFECEEF6),
                          thickness: 1,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              print('Заменить');
                            },
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.transparent,
                              child: const Text(
                                'Заменить',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              childAspectRatio: 1.6,
              crossAxisSpacing: 8,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                NutrientWidget(
                  title: 'Жиры',
                  subtitle: 'гр',
                  nutrient: 12,
                  nutrientDaily: 33,
                ),
                NutrientWidget(
                  title: 'Белки',
                  subtitle: 'гр',
                  nutrient: 1,
                  nutrientDaily: 22,
                ),
                NutrientWidget(
                  title: 'Углеводы',
                  subtitle: 'гр',
                  nutrient: 5,
                  nutrientDaily: 52,
                ),
                NutrientWidget(
                  title: 'Калории',
                  subtitle: 'ккал',
                  nutrient: 1283,
                  nutrientDaily: 2200,
                ),
              ],
            ),
            SizedBox(height: 12),
            GraphWidget(),
          ],
        ),
      ),
    );
  }
}
