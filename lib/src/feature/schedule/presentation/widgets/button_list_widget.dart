import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/models/day_ration_model.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';

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
            context.router.push(
              GenerateScheduleRoute(),
            );
            DependenciesScope.of(context).logger.debug('pushed');
          },
          child: Text('Генерация рациона'),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Резюме на качество')),
        ElevatedButton(
          onPressed: () {
            context.router.push(UserBaseRoute());
          },
          child: Text('База продуктов/блюд'),
        ),
        ElevatedButton(onPressed: () {}, child: Text('История')),
      ],
    );
  }
}
