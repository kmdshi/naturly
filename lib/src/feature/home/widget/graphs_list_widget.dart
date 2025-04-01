import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/stats_graphs_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

class GraphsListWidget extends StatefulWidget {
  const GraphsListWidget({super.key});

  @override
  State<GraphsListWidget> createState() => _GraphsListWidgetState();
}

class _GraphsListWidgetState extends State<GraphsListWidget> {
  int _currentGraphIndex = 0;

  final List<List<DataPoint>> _graphData = [
    [
      DataPoint(0, 0),
      DataPoint(1, 2),
      DataPoint(2, 3),
      DataPoint(3, 4),
      DataPoint(4, 5),
      DataPoint(5, 6),
      DataPoint(6, 7),
      DataPoint(7, 8),
      DataPoint(8, 9),
      DataPoint(9, 10),
      DataPoint(10, 11),
      DataPoint(11, 12),
      DataPoint(12, 13),
      DataPoint(13, 14),
      DataPoint(14, 15),
      DataPoint(15, 16),
      DataPoint(16, 17),
      DataPoint(17, 18),
      DataPoint(18, 19),
      DataPoint(19, 20),
    ],
    [
      DataPoint(0, 2),
      DataPoint(1, 4),
      DataPoint(2, 3),
      DataPoint(3, 6),
      DataPoint(4, 2),
      DataPoint(5, 5),
      DataPoint(6, 12),
      DataPoint(7, 4),
    ],
    [DataPoint(0, 3), DataPoint(1, 2), DataPoint(2, 1), DataPoint(3, 5)],
  ];

  void _changeGraph(int direction) {
    setState(() {
      _currentGraphIndex = (_currentGraphIndex + direction) % _graphData.length;
      if (_currentGraphIndex < 0) _currentGraphIndex = _graphData.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.deepOrange[50]!);
    color.add(Colors.deepOrange[200]!);
    color.add(Colors.deepOrange);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
      colors: color,
      stops: stops,
    );
    return Card(
      child: Column(
        children: [
          Text('Абоба'),
          Column(
            children: [
              SfCartesianChart(
                plotAreaBorderColor: Colors.transparent,
                borderColor: Colors.transparent,
                plotAreaBackgroundColor: Colors.transparent,
                primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(),
                  axisLine: AxisLine(width: 0),
                  minimum: 0,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  axisLine: AxisLine(),
                  majorGridLines: MajorGridLines(),
                  labelFormat: '{value}',
                ),
                enableAxisAnimation: true,
                tooltipBehavior: TooltipBehavior(
                  duration: 1000,
                  enable: true,
                  header: 'Data Point',
                  format: 'point.x : point.y',
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                  zoomMode: ZoomMode.x,
                  enablePinching: true,
                  enableMouseWheelZooming: true,
                ),
                series: [
                  SplineAreaSeries<DataPoint, int>(
                    color: Colors.blueGrey,
                    dataSource: _graphData[_currentGraphIndex],
                    borderWidth: 4,
                    borderColor: Colors.grey,
                    xValueMapper: (DataPoint data, _) => data.x,
                    yValueMapper: (DataPoint data, _) => data.y,
                    onCreateShader: (details) {
                      return ui.Gradient.linear(
                        details.rect.topCenter,
                        details.rect.bottomCenter,
                        [
                          Colors.grey.withOpacity(0.4),
                          Colors.grey.withOpacity(0.1),
                        ],
                      );
                    },
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      width: 6,
                      height: 6,
                    ),
                  ),
               
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left, size: 32),
                    onPressed: () => _changeGraph(-1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_graphData.length, (index) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentGraphIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                        ),
                      );
                    }),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right, size: 32),
                    onPressed: () => _changeGraph(1),
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

List<ChartData> convertToChartData(List<DataPoint> dataPoints) {
  return dataPoints.map((dataPoint) {
    return ChartData(
      dataPoint.x.toDouble(),
      dataPoint.y.toDouble(),
      dataPoint.y.toDouble(),
    );
  }).toList();
}

class ChartData {
  final double below500Value;
  final double highValue;
  final double lowValue;

  ChartData(this.below500Value, this.highValue, this.lowValue);
}

class DataPoint {
  final int x;
  final double y;

  DataPoint(this.x, this.y);
}
