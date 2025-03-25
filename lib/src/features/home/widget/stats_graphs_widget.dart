import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsGraphsWidget extends StatelessWidget {
  const StatsGraphsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, double>> categories = [
      {'A': 400},
      {'B': 600},
      {'C': 350},
      {'D': 700},
    ];

    List<ChartData> chartData = categories.map((data) {
      final category = data.keys.first;
      final value = data[category]!;

      return ChartData(
        category: category,
        value: value,
        above500Value: value > 500 ? value - 500 : 0,
        below500Value: value > 500 ? 500 : value,
      );
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Category Values'),
            series: [
              StackedColumnSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.below500Value,
                name: 'Below 500',
                color: Colors.blue,
              ),
              StackedColumnSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.above500Value,
                name: 'Above 500',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;
  final double above500Value;
  final double below500Value;

  ChartData({
    required this.category,
    required this.value,
    required this.above500Value,
    required this.below500Value,
  });
}
