import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:naturly/src/core/common/layout/layout.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({super.key});

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  final List<double> maxValues = [
    80,
    90,
    100,
    60,
    50,
    70,
    85,
    100,
    90,
    80,
    70,
    90,
  ];
  final List<double> applied = [50, 70, 80, 40, 30, 50, 60, 77, 65, 55, 45, 70];

  @override
  Widget build(BuildContext context) {
    final isPhone =
        WindowSizeScope.of(context).isCompact ||
        WindowSizeScope.of(context).isMedium;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Color(0xFFECEEF6).withValues(alpha: 0.3),
          width: 1.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            'Текущая неделя',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 900,
                child: BarChart(
                  BarChartData(
                    maxY: 110,

                    barGroups: List.generate(applied.length, (index) {
                      final jobApplied = applied[index];
                      final jobView = maxValues[index];
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: jobView,
                            width: isPhone ? 22 : 55,
                            rodStackItems: [
                              BarChartRodStackItem(
                                0,
                                jobApplied,
                                Color(0XFF5932EA),
                              ),
                              BarChartRodStackItem(
                                jobApplied,
                                jobView,
                                Color(0xFFF2EFFF),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      );
                    }),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final months = [
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec',
                            ];
                            return Text(months[value.toInt()]);
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            if (value % 20 == 0 && value <= 100) {
                              return Text(value.toInt().toString());
                            }
                            return const SizedBox.shrink();
                          },
                          reservedSize: 40,
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine:
                          (_) => FlLine(
                            color: Colors.grey.withValues(alpha: 0.1),
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          ),
                    ),

                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
