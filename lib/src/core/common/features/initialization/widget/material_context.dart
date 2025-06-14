import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/cubit/auth_cubit.dart';
import 'package:naturly/src/core/common/router/router.dart';
import 'package:naturly/src/core/constant/localization/localization.dart';
import 'package:naturly/src/core/common/features/initialization/widget/dependencies_scope.dart';
import 'package:naturly/src/core/widget/side_drawer.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/core/common/features/settings/model/app_theme.dart';
import 'package:naturly/src/core/common/features/settings/widget/settings_scope.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';
import 'package:naturly/src/feature/settings/presentation/bloc/settings_bloc.dart';

class MaterialContext extends StatelessWidget {
  const MaterialContext({super.key});

  static final _globalKey = GlobalKey(debugLabel: 'MaterialContext');

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context);
    final mediaQueryData = MediaQuery.of(context);

    final theme = settings.appTheme ?? AppTheme.defaultTheme;
    
    final lightTheme = theme.buildThemeData(Brightness.light);
    final darkTheme = theme.buildThemeData(Brightness.dark);
    final router = AppRouter();
    final themeMode = theme.themeMode;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
          create: (context) => DependenciesScope.of(context).accountBloc,
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => DependenciesScope.of(context).scheduleBloc,
        ),
        BlocProvider<UserbaseBloc>(
          create: (context) => DependenciesScope.of(context).userbaseBloc,
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => DependenciesScope.of(context).settingsBloc,
        ),
        BlocProvider<AuthCubit>(
          create: (context) => DependenciesScope.of(context).authCubit,
        ),
      ],
      child: MaterialApp.router(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        locale: settings.locale,
        localizationsDelegates: Localization.localizationDelegates,
        supportedLocales: Localization.supportedLocales,
        routerConfig: router.config(),
        builder:
            (context, router) => Scaffold(
              drawer: SideDrawer(),
              body: MediaQuery(
                key: _globalKey,
                data: mediaQueryData.copyWith(
                  textScaler: TextScaler.linear(
                    mediaQueryData.textScaler
                        .scale(settings.textScale ?? 1)
                        .clamp(0.5, 2),
                  ),
                ),
                child: router!,
              ),
            ),
      ),
    );
  }
}
