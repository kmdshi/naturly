import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/features/account/presentation/widgets/option_widget.dart';

@RoutePage()
class ProfileDataFillScreen extends StatefulWidget {
  const ProfileDataFillScreen({super.key});

  @override
  State<ProfileDataFillScreen> createState() => _ProfileDataFillScreenState();
}

class _ProfileDataFillScreenState extends State<ProfileDataFillScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
              'Давайте заполним данные о вас...(все анонимно, они пригодятся для всевозможных рассчетов.)'),
          OptionWidget(
            title: 'Сколько вы весите?',
            isTextQuestion: true,
          ),
          OptionWidget(
            title: 'Сколько вы весите?',
            isTextQuestion: true,
          ),
          OptionWidget(
            title: 'Сколько вы весите?',
            isTextQuestion: true,
          ),
          OptionWidget(
              title: 'Уровень вашей активности в течение дня?',
              answers: [
                'Очень мало',
                'Умеренная',
                'Средняя',
                'Высокая',
              ]),
          //TODO: сделать чекбокс выборы:
          // OptionWidget(
          //   title: 'Есть ли ограничения?',

          // ),
        ],
      ),
    );
  }
}
