import 'package:flutter/material.dart';
import 'package:naturly/src/features/schedule/presentation/generate_schedule_screen.dart';

class ButtonListWidget extends StatefulWidget {
  const ButtonListWidget({super.key});

  @override
  State<ButtonListWidget> createState() => _ButtonListWidgetState();
}

class _ButtonListWidgetState extends State<ButtonListWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return GenerateScheduleScreen();
                },
              ),
            );
          },
          child: Text('Генерация рациона'),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Резюме на качество')),
        ElevatedButton(onPressed: () {}, child: Text('База продуктов/блюд')),
        ElevatedButton(onPressed: () {}, child: Text('История')),
      ],
    );
  }
}
