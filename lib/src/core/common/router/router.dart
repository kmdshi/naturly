import 'package:auto_route/auto_route.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          if (Supabase.instance.client.auth.currentSession != null) {
            resolver.next();
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
