import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/models/human_profile.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/option_widget.dart';

@RoutePage()
class ProfileDataFillScreen extends StatefulWidget {
  const ProfileDataFillScreen({super.key});

  @override
  State<ProfileDataFillScreen> createState() => _ProfileDataFillScreenState();
}

class _ProfileDataFillScreenState extends State<ProfileDataFillScreen> {
  ValueNotifier<String> nicknameNotifier = ValueNotifier<String>('');
  ValueNotifier<String> ageNotifier = ValueNotifier<String>('');
  ValueNotifier<String> weightNotifier = ValueNotifier<String>('');
  ValueNotifier<String> heightNotifier = ValueNotifier<String>('');
  ValueNotifier<String> activityLevelNotifier = ValueNotifier<String>(
    'Sedentary',
  );
  ValueNotifier<String> sexNotifier = ValueNotifier<String>('');

  ValueNotifier<String> restrictionsNotifier = ValueNotifier<String>('');
  ValueNotifier<String> goalNotifier = ValueNotifier<String>('Поддержать');

  @override
  void dispose() {
    nicknameNotifier.dispose();
    ageNotifier.dispose();
    weightNotifier.dispose();
    heightNotifier.dispose();
    activityLevelNotifier.dispose();
    goalNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountAuthorized) {
            Future.microtask(() {
              context.router.pushAndPopUntil(
                HomeTab(),
                predicate: (route) => false,
              );
            });
            return SizedBox.shrink();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Давайте заполним данные о вас...(все анонимно, они пригодятся для всевозможных рассчетов.)',
                  ),
                  OptionWidget(
                    title: 'Как вас называть?',
                    isTextQuestion: true,
                    value: nicknameNotifier,
                  ),
                  OptionWidget(
                    title: 'Какой ваш возраст?',
                    isTextQuestion: true,
                    value: ageNotifier,
                  ),
                  OptionWidget(
                    title: 'Сколько вы весите?',
                    isTextQuestion: true,
                    value: weightNotifier,
                  ),
                  OptionWidget(
                    title: 'Какой у вас рост?',
                    isTextQuestion: true,
                    value: heightNotifier,
                  ),
                  OptionWidget(
                    title: 'Уровень вашей активности в течение дня?',
                    answers: [
                      'Sedentary',
                      'Lightly active',
                      'Moderately active',
                      'Very active',
                      'Extra active',
                    ],
                    value: activityLevelNotifier,
                  ),
                  OptionWidget(
                    title: 'Ваш пол?',
                    answers: ['Мужской', 'Женский'],
                    value: sexNotifier,
                  ),
                  OptionWidget(
                    title: 'Какие у вас ограничения',
                    isRestrictions: true,
                    value: restrictionsNotifier,
                  ),
                  OptionWidget(
                    title: 'Ваша цель?',
                    answers: ['Набрать', 'Сбросить', 'Поддержать'],
                    value: goalNotifier,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (nicknameNotifier.value.isEmpty ||
                          ageNotifier.value.isEmpty ||
                          weightNotifier.value.isEmpty ||
                          heightNotifier.value.isEmpty ||
                          activityLevelNotifier.value.isEmpty ||
                          sexNotifier.value.isEmpty ||
                          goalNotifier.value.isEmpty) {
                        print('Все поля должны быть заполнены');
                        return;
                      }

                      final selectedRestrictions =
                          restrictionsNotifier.value
                              .split(',')
                              .map((restriction) => restriction.trim())
                              .where((restriction) => restriction.isNotEmpty)
                              .toSet();

                      final user = Human(
                        nickName: nicknameNotifier.value,
                        age: int.parse(ageNotifier.value),
                        height: int.parse(heightNotifier.value),
                        weight: int.parse(weightNotifier.value),
                        goal: goalNotifier.value,
                        restrictions: selectedRestrictions,
                        sex: sexNotifier.value,
                        activityLevel: activityLevelNotifier.value,
                      );
                      context.read<AccountBloc>().add(
                        AccountFillEvent(user: user),
                      );
                    },
                    child: Text('Дальше'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
