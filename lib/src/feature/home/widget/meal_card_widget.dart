import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/animated_line_widget.dart';

class MealCardWidget extends StatefulWidget {
  const MealCardWidget({super.key});

  @override
  State<MealCardWidget> createState() => _MealCardWidgetState();
}

class _MealCardWidgetState extends State<MealCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.asset(
                'assets/images/aa.jpg',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            top: 200,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Malai Cofa',
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xFF432912),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            AnimantedLineWidget(
                              goal: 550,
                              eaten: 200,
                              completedColor: Color(0xFFFFA115),
                            ),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calories',
                                  style: TextStyle(
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(
                                      0xFF432912,
                                    ).withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  '411.0',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF432912),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            AnimantedLineWidget(
                              goal: 550,
                              eaten: 200,
                              completedColor: Color(0xFF2E81CD),
                            ),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fats',
                                  style: TextStyle(
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(
                                      0xFF432912,
                                    ).withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  '15.2g',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF432912),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            AnimantedLineWidget(
                              goal: 550,
                              eaten: 200,
                              completedColor: Color(0xFFFF4D15),
                            ),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Carbs',
                                  style: TextStyle(
                                    fontFamily: 'Figtree',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(
                                      0xFF432912,
                                    ).withValues(alpha: 0.8),
                                  ),
                                ),
                                Text(
                                  '33.5g',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF432912),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 3,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/check-circle.png',
                    color: Color(0xFF7AB737),
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 5),
                  Text('Mark as eaten'),
                ],
              ),
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Color(0xFFF2F8EB)),
                elevation: WidgetStatePropertyAll(0),
                foregroundColor: WidgetStatePropertyAll(Color(0xFF4D7C19)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
