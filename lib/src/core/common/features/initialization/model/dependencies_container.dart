// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:naturly/src/core/common/error_reporter/error_reporter.dart';
import 'package:naturly/src/core/constant/application_config.dart';
import 'package:naturly/src/core/common/features/settings/bloc/app_settings_bloc.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';

class DependenciesContainer {
  const DependenciesContainer({
    required this.logger,
    required this.config,
    required this.appSettingsBloc,
    required this.accountBloc,
    required this.scheduleBloc,
    required this.userbaseBloc,
    required this.errorReporter,
    required this.packageInfo,
  });

  final Logger logger;

  final ApplicationConfig config;

  final AppSettingsBloc appSettingsBloc;

  final AccountBloc accountBloc;

  final ScheduleBloc scheduleBloc;

  final UserbaseBloc userbaseBloc;

  final ErrorReporter errorReporter;

  final PackageInfo packageInfo;
}

base class TestDependenciesContainer implements DependenciesContainer {
  const TestDependenciesContainer();

  @override
  Object noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
