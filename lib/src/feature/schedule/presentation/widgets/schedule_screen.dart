import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/widgets/button_list_widget.dart';
import 'package:naturly/src/core/widget/current_schedule_widget.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    context.read<ScheduleBloc>().add(ScheduleGetWeekUserRationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<ScheduleBloc, ScheduleState>(
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
                      CurrentScheduleWidget(
                        ration: state.ration,
                        isView: false,
                      ),
                      SizedBox(height: 15),
                      ButtonListWidget(
                        buttons: [
                          ElevatedButton(
                            onPressed:
                                () => context.router.push(
                                  GenerateScheduleRoute(),
                                ),
                            child: Text('Генерация рациона'),
                          ),
                          ElevatedButton(
                            onPressed:
                                () => context.router.push(UserBaseRoute()),
                            child: Text('База продуктов/блюд'),
                          ),
                          ElevatedButton(
                            onPressed:
                                () => context.router.push(HistoryRoute()),
                            child: Text('История'),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                return Center(child: Text('Непредвиденное состояние'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
