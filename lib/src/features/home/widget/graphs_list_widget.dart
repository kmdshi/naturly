import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphsListWidget extends StatefulWidget {
  const GraphsListWidget({super.key});

  @override
  State<GraphsListWidget> createState() => _GraphsListWidgetState();
}

class _GraphsListWidgetState extends State<GraphsListWidget> {
  int _currentGraphIndex = 0;

  final List<List<DataPoint>> _graphData = [
    [
      DataPoint(0, 1),
      DataPoint(1, 3),
      DataPoint(2, 5),
      DataPoint(10, 2),
      DataPoint(5, 3),
      DataPoint(6, 43),
      DataPoint(2, 55),
      DataPoint(10, 2),
      DataPoint(0, 14),
      DataPoint(1, 32),
      DataPoint(21, 5),
      DataPoint(10, 2),
      DataPoint(30, 1),
      DataPoint(14, 3),
      DataPoint(2, 5),
      DataPoint(160, 2),
      DataPoint(012, 1),
      DataPoint(12, 3),
      DataPoint(32, 5),
      DataPoint(10, 2),
      DataPoint(05, 1),
      DataPoint(1, 3),
      DataPoint(2, 5),
      DataPoint(10, 2),
    ],
    [
      DataPoint(0, 2),
      DataPoint(1, 4),
      DataPoint(2, 6),
      DataPoint(3, 1),
    ],
    [
      DataPoint(0, 3),
      DataPoint(1, 2),
      DataPoint(2, 1),
      DataPoint(3, 5),
    ],
  ];

  void _changeGraph(int direction) {
    setState(() {
      _currentGraphIndex = (_currentGraphIndex + direction) % _graphData.length;
      if (_currentGraphIndex < 0) _currentGraphIndex = _graphData.length - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text('Абоба'),
          Column(
            children: [
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
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
                  LineSeries<DataPoint, int>(
                    dataSource: _graphData[_currentGraphIndex],
                    xValueMapper: (DataPoint data, _) => data.x,
                    yValueMapper: (DataPoint data, _) => data.y,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      width: 6,
                      height: 6,
                      color: Colors.red,
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
                          color: _currentGraphIndex == index
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

class DataPoint {
  final int x;
  final double y;

  DataPoint(this.x, this.y);
}
