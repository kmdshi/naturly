import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/features/schedule/presentation/current_schedule_widget.dart';

@RoutePage()
class GenerateScheduleScreen extends StatefulWidget {
  const GenerateScheduleScreen({super.key});

  @override
  State<GenerateScheduleScreen> createState() => _GenerateScheduleScreenState();
}

class _GenerateScheduleScreenState extends State<GenerateScheduleScreen> {
  Map<String, Map<String, List<String>>> schedule = {};

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
                onPressed: () {},
                child: Text(
                  'Сгенерировать на неделю',
                ),
              )
            ],
          )
        ],
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
            child: Column(
              children: [Text('Тест')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Сгенерировать'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
