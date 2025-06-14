// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NutrientWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final int nutrient;
  final int nutrientDaily;

  const NutrientWidget({
    super.key,
    required this.title,
    required this.nutrient,
    required this.nutrientDaily,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Color(0xFFECEEF6).withValues(alpha: 0.3),
          width: 1.6,
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('${nutrient.toString()}/${nutrientDaily.toString()}'),
          Text(subtitle ?? ''),
        ],
      ),
    );
  }
}
