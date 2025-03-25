// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:naturly/src/core/presentation/root_screen.dart' as _i5;
import 'package:naturly/src/features/account/presentation/widgets/login_screen.dart'
    as _i2;
import 'package:naturly/src/features/account/presentation/widgets/profile_data_fill_screen.dart'
    as _i3;
import 'package:naturly/src/features/account/presentation/widgets/registration_screen.dart'
    as _i4;
import 'package:naturly/src/features/home/widget/home_screen.dart' as _i1;
import 'package:naturly/src/features/schedule/presentation/schedule_screen.dart'
    as _i6;
import 'package:naturly/src/features/settings/presentation/settings_screen.dart'
    as _i7;

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.ProfileDataFillScreen]
class ProfileDataFillRoute extends _i8.PageRouteInfo<void> {
  const ProfileDataFillRoute({List<_i8.PageRouteInfo>? children})
    : super(ProfileDataFillRoute.name, initialChildren: children);

  static const String name = 'ProfileDataFillRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.ProfileDataFillScreen();
    },
  );
}

/// generated route for
/// [_i4.RegistrationScreen]
class RegistrationRoute extends _i8.PageRouteInfo<void> {
  const RegistrationRoute({List<_i8.PageRouteInfo>? children})
    : super(RegistrationRoute.name, initialChildren: children);

  static const String name = 'RegistrationRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.RegistrationScreen();
    },
  );
}

/// generated route for
/// [_i5.RootScreen]
class RootRoute extends _i8.PageRouteInfo<void> {
  const RootRoute({List<_i8.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.RootScreen();
    },
  );
}

/// generated route for
/// [_i6.ScheduleScreen]
class ScheduleRoute extends _i8.PageRouteInfo<void> {
  const ScheduleRoute({List<_i8.PageRouteInfo>? children})
    : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.ScheduleScreen();
    },
  );
}

/// generated route for
/// [_i7.SettingsScreen]
class SettingsRoute extends _i8.PageRouteInfo<void> {
  const SettingsRoute({List<_i8.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SettingsScreen();
    },
  );
}
