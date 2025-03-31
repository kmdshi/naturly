import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/feature/home/widget/graphs_list_widget.dart';
import 'package:naturly/src/feature/home/widget/static_info_widget.dart';
import 'package:naturly/src/feature/home/widget/stats_graphs_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 2, child: GraphsListWidget()),
                  SizedBox(width: 10),
                  StaticInfoWidget(
                    text:
                        'Ваша цель:\nАктивность:\nКкал:\n-Белки:\n-Жиры:\n-Углеводы:\nСон:\nВода:',
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(flex: 2, child: StatsGraphsWidget()),
                  SizedBox(width: 10),
                  StaticInfoWidget(
                    text:
                        'Ваша цель:\nАктивность:\nКкал:\n-Белки:\n-Жиры:\n-Углеводы:\nСон:\nВода:',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
