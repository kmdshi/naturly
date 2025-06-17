import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';
import 'package:naturly/src/core/widget/current_schedule_widget.dart';

@RoutePage()
class UserHistoryWeekScreen extends StatelessWidget {
  final WeekRation weekRation;
  const UserHistoryWeekScreen({super.key, required this.weekRation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CurrentScheduleWidget(ration: weekRation, isView: true),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
