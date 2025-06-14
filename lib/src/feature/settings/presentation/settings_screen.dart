import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/features/settings/bloc/app_settings_bloc.dart';
import 'package:naturly/src/core/common/features/settings/model/app_theme.dart';
import 'package:naturly/src/core/common/features/settings/widget/settings_scope.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/feature/settings/presentation/bloc/settings_bloc.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            Future.delayed(Duration.zero, () {
              context.router.pushAndPopUntil(
                RootRoute(),
                predicate: (route) => false,
              );
            });
            return SizedBox.shrink();
          } else if (state is SettingsFailure) {
            return Center(child: Text('Ошибка: ${state.message}'));
          }

          return Column(
            children: [
              Text('Настройки'),
              ElevatedButton(
                onPressed: () async {
                  final currentSettings = SettingsScope.settingsOf(context);

                  SettingsScope.of(context).add(
                    AppSettingsEvent.updateAppSettings(
                      appSettings: currentSettings.copyWith(
                        appTheme: AppTheme(
                          themeMode:
                              currentSettings.appTheme?.themeMode ==
                                      ThemeMode.light
                                  ? ThemeMode.dark
                                  : ThemeMode.light,
                        ),
                      ),
                    ),
                  );
                },
                child: Text('Сменить тему'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SettingsBloc>().add(SettingsLogOutEvent());
                },
                child: Text('Выйти с аккаунта'),
              ),
            ],
          );
        },
      ),
    );
  }
}
