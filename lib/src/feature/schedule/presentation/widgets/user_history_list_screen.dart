import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/common/models/week_ration.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(ScheduleGetAllWeeksUserRationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // TODO: подумать над альтернативой этому вызову
            context.read<ScheduleBloc>().add(ScheduleGetWeekUserRationEvent());
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ScheduleHistoryLoaded) {
            if (state.history[0] == WeekRation.empty()) {
              return const Center(child: Text("История пуста"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final week = state.history[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text('Неделя: №${index + 1}'),
                    subtitle: Text('Дней: ${week.foodData.length}'),
                    onTap:
                        () => context.router.push(
                          UserHistoryWeekRoute(weekRation: week),
                        ),
                  ),
                );
              },
            );
          }

          if (state is ScheduleFailure) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }

          return const Center(child: Text("Нет данных"));
        },
      ),
    );
  }
}
