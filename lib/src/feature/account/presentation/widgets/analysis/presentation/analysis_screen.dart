import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage() 
class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('анализ'),
      ),
    );
  }
}
