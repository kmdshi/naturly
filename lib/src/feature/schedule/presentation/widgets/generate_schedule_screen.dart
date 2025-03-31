// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/current_schedule_widget.dart';

@RoutePage()
class GenerateScheduleScreen extends StatefulWidget {
  const GenerateScheduleScreen({super.key});

  @override
  State<GenerateScheduleScreen> createState() => _GenerateScheduleScreenState();
}

class _GenerateScheduleScreenState extends State<GenerateScheduleScreen> {
  final me = Human(
    age: 17,
    height: 187,
    weight: 68,
    goal: 'lose',
    restrictions: {},
    sex: 'male',
    activityLevel: 'Sedentary',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генерация рациона'),
        actions: [
          IconButton(onPressed: _showOptionsDialog, icon: Icon(Icons.settings)),
        ],
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ScheduleFailure) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }

          if (state is ScheduleLoaded) {
            return Column(
              children: [
                CurrentScheduleWidget(schedule: state.ration),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          () => context.read<ScheduleBloc>().add(
                            ScheduleAddUserRation(ration: state.ration),
                          ),
                      child: Text('Сохранить'),
                    ),
                    ElevatedButton(
                      onPressed:
                          () => context.read<ScheduleBloc>().add(
                            ScheduleGenerateDayRation(person: me),
                          ),
                      child: Text('Сгенерировать на день'),
                    ),
                    ElevatedButton(
                      onPressed:
                          () => context.read<ScheduleBloc>().add(
                            ScheduleGenerateWeekRation(person: me),
                          ),

                      child: Text('Сгенерировать на неделю'),
                    ),
                  ],
                ),
              ],
            );
          }

          return Center(child: Text('Непредвиденное состояние'));
        },
      ),
    );
  }

  Future<void> _showOptionsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите параметры для генерации'),
          content: const SingleChildScrollView(
            child: Column(children: [Text('Тест')]),
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
