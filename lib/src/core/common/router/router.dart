import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/cubit/auth_cubit.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
      initial: true,
      guards: [
        AutoRouteGuard.simple((resolver, _) {
          final context = resolver.context;

          final authState = BlocProvider.of<AuthCubit>(context).state;

          if (authState is AuthAuthenticated) {
            resolver.next(true);
          } else {
            resolver.redirectUntil(LoginRoute());
          }
        }),
      ],
      children: [
        AutoRoute(
          path: '',
          page: HomeTab.page,
          children: [AutoRoute(path: '', page: HomeRoute.page)],
        ),
        AutoRoute(
          path: 'schedule',
          page: ScheduleTab.page,
          children: [
            AutoRoute(path: '', page: ScheduleRoute.page),
            AutoRoute(path: 'generate', page: GenerateScheduleRoute.page),
            AutoRoute(path: 'userbase', page: UserBaseRoute.page),
          ],
        ),
        AutoRoute(
          path: 'analysis',
          page: AnalysisTab.page,
          children: [AutoRoute(path: '', page: AnalysisRoute.page)],
        ),

        AutoRoute(
          path: 'settings',
          page: SettingsTab.page,
          children: [AutoRoute(path: '', page: SettingsRoute.page)],
        ),
      ],
    ),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/reg', page: RegistrationRoute.page),
    AutoRoute(path: '/fill', page: ProfileDataFillRoute.page),
  ];
}
