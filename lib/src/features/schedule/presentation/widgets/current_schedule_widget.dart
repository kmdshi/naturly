import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naturly/src/features/schedule/domain/models/day_ration_model.dart';

class CurrentScheduleWidget extends StatelessWidget {
  final List<DayRation> schedule;

  const CurrentScheduleWidget({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(color: Colors.black12),
        columnWidths: const {
          0: IntrinsicColumnWidth(),
        },
        children: [
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'День недели',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    getDayName(DateTime.now().add(Duration(days: i)), true),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Завтрак',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < schedule.length)
                        ? (schedule[i].morningDish?.toString() ?? '-')
                        : '-',
                  ),
                ),
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Обед',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < schedule.length)
                        ? (schedule[i].lunchDish?.toString() ?? '-')
                        : '-',
                  ),
                ),
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Перекус',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < schedule.length)
                        ? (schedule[i].snackDish?.toString() ?? '-')
                        : '-',
                  ),
                ),
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Ужин',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < schedule.length)
                        ? (schedule[i].dinnerDish?.toString() ?? '-')
                        : '-',
                  ),
                ),
            ],
          ),
          TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Text(
                  'Калории',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              for (int i = 0; i < 7; i++)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    (i < schedule.length)
                        ? (schedule[i].totalCcal?.toString() ?? '-')
                        : '-',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

String getDayName(DateTime date, bool forTable) {
  return forTable
      ? DateFormat('EEE, d').format(date)
      : DateFormat('EEE').format(date);
}
