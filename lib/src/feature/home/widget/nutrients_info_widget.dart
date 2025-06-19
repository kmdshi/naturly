// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/animated_ring_widget.dart';

class NutrientsWidget extends StatelessWidget {
  final int caloriesGoal;
  final int eatenCalories;
  final int proteinGoal;
  final int proteinEaten;
  final int fatsGoal;
  final int fatsEaten;
  final int carbsGoal;
  final int carbsEaten;
  const NutrientsWidget({
    super.key,
    required this.caloriesGoal,
    required this.eatenCalories,
    required this.proteinGoal,
    required this.proteinEaten,
    required this.fatsGoal,
    required this.fatsEaten,
    required this.carbsGoal,
    required this.carbsEaten,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFECEEF6).withValues(alpha: 0.3),
          width: 1.6,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Focus',
            style: TextStyle(
              fontFamily: 'Figtree',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF432912),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Goal',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF432912).withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '1655.0 calories',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF432912),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
                child: VerticalDivider(
                  width: 12,
                  thickness: 1,
                  color: Color(0xFFEDE9E4),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eaten',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF432912).withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '400.0 calories',
                      style: TextStyle(
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF432912),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.center,
            child: AnimantedRingWidget(
              goal: 2000,
              eaten: 1000,
              completedColor: Color(0xFF7AB737),
              isNeedDonut: true,
              size: 200,
              strokeWidth: 15,
              centerData: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/calories.png',
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '1488.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Color(0xFF432912),
                    ),
                  ),
                  Text(
                    'kcal left',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xFF432912).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimantedRingWidget(
                    goal: 1000,
                    eaten: 500,
                    completedColor: Color(0xFF2E81CD),
                    size: 50,
                    strokeWidth: 4,
                  ),
                  Text(
                    'Protein',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF432912),
                    ),
                  ),
                  Text(
                    '12.0/55.0g',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF432912).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 35,
                child: VerticalDivider(
                  width: 12,
                  thickness: 1,
                  color: Color(0xFFEDE9E4),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimantedRingWidget(
                    goal: 1300,
                    eaten: 100,
                    completedColor: Color(0xFFFFA115),
                    size: 50,
                    strokeWidth: 4,
                  ),
                  Text(
                    'Carbs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Color(0xFF432912),
                    ),
                  ),
                  Text(
                    '12.0/55.0g',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF432912).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 35,
                child: VerticalDivider(
                  width: 12,
                  thickness: 1,
                  color: Color(0xFFEDE9E4),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimantedRingWidget(
                    goal: 1203,
                    eaten: 444,
                    completedColor: Color(0xFFFF4D15),
                    strokeWidth: 4,
                    size: 50,
                  ),
                  Text(
                    'Fat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF432912),
                    ),
                  ),
                  Text(
                    '12.0/55.0g',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Figtree',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xFF432912).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
