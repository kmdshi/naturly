import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/features/schedule/presentation/button_list_widget.dart';
import 'package:naturly/src/features/schedule/presentation/current_schedule_widget.dart';

@RoutePage()
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final currentSchedule = {
    'Понедельник': {
      'Завтрак': ['Овсянка с фруктами', 'Чай'],
      'Обед': ['Курица с рисом', 'Салат из капусты', 'Компот'],
      'Перекус': ['Член большой'],
      'Ужин': ['Салат с тунцом', 'Гречка', 'Кефир'],
    },
    'Вторник': {
      'Завтрак': ['Яичница с тостами', 'Кофе'],
      'Обед': ['Борщ с хлебом', 'Котлета', 'Чай'],
      'Ужин': ['Гречка с грибами', 'Огурцы', 'Ряженка'],
    },
    'Среда': {
      'Завтрак': ['Творог с мёдом', 'Орехи'],
      'Обед': ['Котлета с картофельным пюре', 'Свекольный салат', 'Морс'],
      'Ужин': ['Овощное рагу', 'Рис', 'Чай'],
    },
    'Четверг': {
      'Завтрак': ['Блинчики с вареньем', 'Какао'],
      'Обед': ['Паста с томатным соусом', 'Куриное филе', 'Сок'],
      'Ужин': ['Рыба с овощами', 'Картофель', 'Йогурт'],
    },
    'Пятница': {
      'Завтрак': ['Смузи с овсянкой', 'Орехи'],
      'Обед': ['Плов с говядиной', 'Капустный салат', 'Чай'],
      'Ужин': ['Суп-пюре из тыквы', 'Гренки', 'Молоко'],
    },
    'Суббота': {
      'Завтрак': ['Хлопья с молоком', 'Фрукты'],
      'Обед': ['Суп-лапша', 'Куриные наггетсы', 'Компот'],
      'Ужин': ['Рагу из овощей', 'Макароны', 'Кефир'],
    },
    'Воскресенье': {
      'Завтрак': ['Тосты с авокадо', 'Апельсиновый сок'],
      'Обед': ['Гуляш с гречкой', 'Капустный салат', 'Чай'],
      'Ужин': ['Омлет с овощами', 'Сырники', 'Йогурт'],
    },
  };
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
