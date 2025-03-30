import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/features/schedule/domain/models/day_ration_model.dart';
import 'package:naturly/src/features/schedule/presentation/widgets/button_list_widget.dart';
import 'package:naturly/src/features/schedule/presentation/widgets/current_schedule_widget.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<DayRation> currentSchedule = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CurrentScheduleWidget(
              schedule: currentSchedule,
            ),
            SizedBox(height: 15),
            ButtonListWidget()
          ],
        ),
      ),
    );
  }
}
