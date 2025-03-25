import 'package:auto_route/auto_route.dart';
import 'package:naturly/src/core/router/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          initial: true,
          guards: [
            AutoRouteGuard.simple(
              (resolver, _) {
                // TODO: проверку на авторизацию
                // bool a = false;
                // if (a) {
                resolver.next();
                // } else {
                //   resolver.redirectUntil(LoginRoute());
                // }
              },
            ),
          ],
          children: [
            AutoRoute(
              path: 'home',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'schedule',
              page: ScheduleRoute.page,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsRoute.page,
            )
          ],
        ),
        AutoRoute(
          path: '/login',
          page: LoginRoute.page,
        ),
        AutoRoute(
          path: '/reg',
          page: RegistrationRoute.page,
        ),
        AutoRoute(
          path: '/fill',
          page: ProfileDataFillRoute.page,
        ),
      ];
}
