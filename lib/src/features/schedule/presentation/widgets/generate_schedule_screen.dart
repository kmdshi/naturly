import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naturly/src/core/services/food_service.dart';
import 'package:naturly/src/features/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/features/schedule/data/repository/generate_schedule_repository.dart';
import 'package:naturly/src/features/schedule/domain/models/day_ration_model.dart';
import 'package:naturly/src/features/schedule/domain/models/human_profile.dart';
import 'package:naturly/src/features/schedule/domain/repository/generate_schedule_repository.dart';
import 'package:naturly/src/features/schedule/presentation/widgets/current_schedule_widget.dart';

@RoutePage()
class GenerateScheduleScreen extends StatefulWidget {
  const GenerateScheduleScreen({super.key});

  @override
  State<GenerateScheduleScreen> createState() => _GenerateScheduleScreenState();
}

class _GenerateScheduleScreenState extends State<GenerateScheduleScreen> {
  GenerateScheduleRepository a = GenerateScheduleRepositoryImpl(
      foodService: FoodService(), scheduleRemoteDs: ScheduleSupabaseRemoteDS());
  List<DayRation> schedule = [];

  var day = 'ЯЯЯЯЯЯЯ ТУТ';
  var inq = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генерация рациона'),
        actions: [
          IconButton(
            onPressed: _showOptionsDialog,
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          CurrentScheduleWidget(
            schedule: schedule,
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Сохранить',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  DayRation newRation = await a.generateDayRation(
                      getDayName(DateTime.now(), false),
                      DateTime.now().weekday,
                      Human(
                        age: 17,
                        height: 187,
                        weight: 68,
                        goal: 'lose',
                        restrictions: {},
                        sex: 'male',
                        activityLevel: 'Sedentary',
                      ));

                  setState(() {
                    inq = schedule
                        .indexWhere((el) => el.day!.isSameDate(newRation.day!));
                    if (inq != -1) {
                      schedule[inq] = newRation;
                    } else {
                      schedule.add(newRation);
                    }
                  });
                },
                child: Text(
                  'Сгенерировать на день',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<DayRation> newRation = await a.generateWeekRation(Human(
                    age: 17,
                    height: 187,
                    weight: 68,
                    goal: 'lose',
                    restrictions: {},
                    sex: 'male',
                    activityLevel: 'Sedentary',
                  ));

                  setState(() {
                    schedule = newRation;
                  });
                },
                child: Text(
                  'Сгенерировать на неделю',
                ),
              ),
            ],
          ),
          Expanded(child: Text('${schedule.toString()} ${inq}')),
        ],
      ),
    );
  }

  String getDayName(DateTime date, bool forTable) {
    return forTable
        ? DateFormat('EEE, d').format(date)
        : DateFormat('EEE').format(date);
  }

  Future<void> _showOptionsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите параметры для генерации'),
          content: const SingleChildScrollView(
            child: Column(
              children: [Text('Тест')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Сгенерировать'),
              onPressed: () async {},
            ),
          ],
        );
      },
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
