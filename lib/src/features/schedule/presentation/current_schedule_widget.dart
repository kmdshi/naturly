import 'package:flutter/material.dart';

class CurrentScheduleWidget extends StatelessWidget {
  final Map<String, Map<String, List>>? schedule;

  const CurrentScheduleWidget({
    super.key,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    if (schedule == null || schedule!.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Table(
          border: TableBorder.all(color: Colors.black12),
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
                ...[
                  'Понедельник',
                  'Вторник',
                  'Среда',
                  'Четверг',
                  'Пятница',
                  'Суббота',
                  'Воскресенье'
                ].map((el) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      el,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                })
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
                ...List.generate(7, (index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(''),
                  );
                }),
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
                ...List.generate(7, (index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(''),
                  );
                }),
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
                ...List.generate(7, (index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(''),
                  );
                }),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Table(
        border: TableBorder.all(color: Colors.black12),
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
              for (final day in schedule!.keys)
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
          ...schedule!.entries.first.value.keys.map((mealType) {
            return TableRow(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    mealType,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                for (final day in schedule!.keys)
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: schedule?[day]?[mealType]
                              ?.map(
                                (meal) => Text(meal),
                              )
                              .toList() ??
                          [Text('Нет данных')],
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
