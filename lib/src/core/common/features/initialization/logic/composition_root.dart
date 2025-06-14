import 'package:clock/clock.dart';
import 'package:logger/logger.dart';
import 'package:naturly/src/core/common/cubit/auth_cubit.dart';
import 'package:naturly/src/core/common/services/food_service.dart';
import 'package:naturly/src/feature/account/data/data_source/remote/supabase_account_ds.dart';
import 'package:naturly/src/feature/account/data/repository/account_init_repository.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/schedule/data/data_source/remote/schedule_remote_ds.dart';
import 'package:naturly/src/feature/schedule/data/repository/schedule_repository.dart';
import 'package:naturly/src/feature/schedule/data/repository/user_base_repository.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/schedule_bloc/schedule_bloc.dart';
import 'package:naturly/src/feature/schedule/presentation/blocs/userbase_bloc/bloc/userbase_bloc.dart';
import 'package:naturly/src/feature/settings/data/datasources/supabase_settings_ds.dart';
import 'package:naturly/src/feature/settings/data/repository/settings_repository.dart';
import 'package:naturly/src/feature/settings/presentation/bloc/settings_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:naturly/src/core/common/error_reporter/error_reporter.dart';
import 'package:naturly/src/core/common/error_reporter/sentry_error_reporter.dart';
import 'package:naturly/src/core/constant/application_config.dart';
import 'package:naturly/src/core/common/features/initialization/model/dependencies_container.dart';
import 'package:naturly/src/core/common/features/settings/bloc/app_settings_bloc.dart';
import 'package:naturly/src/core/common/features/settings/data/app_settings_datasource.dart';
import 'package:naturly/src/core/common/features/settings/data/app_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class CompositionRoot {
  const CompositionRoot({
    required this.config,
    required this.logger,
    required this.errorReporter,
  });

  final ApplicationConfig config;

  final Logger logger;

  final ErrorReporter errorReporter;

  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');

    final dependencies = await createDependenciesContainer(
      config,
      logger,
      errorReporter,
    );

    stopwatch.stop();
    logger.info(
      'Dependencies initialized successfully in ${stopwatch.elapsedMilliseconds} ms.',
    );

    return CompositionResult(
      dependencies: dependencies,
      millisecondsSpent: stopwatch.elapsedMilliseconds,
    );
  }
}

final class CompositionResult {
  const CompositionResult({
    required this.dependencies,
    required this.millisecondsSpent,
  });

  final DependenciesContainer dependencies;

  final int millisecondsSpent;

  @override
  String toString() =>
      'CompositionResult('
      'dependencies: $dependencies, '
      'millisecondsSpent: $millisecondsSpent'
      ')';
}

Future<DependenciesContainer> createDependenciesContainer(
  ApplicationConfig config,
  Logger logger,
  ErrorReporter errorReporter,
) async {
  final sharedPreferences = SharedPreferencesAsync();

  final supabaseClient = Supabase.instance.client;
  
  final foodService = FoodService();

  final packageInfo = await PackageInfo.fromPlatform();

  final appSettingsBloc = await createAppSettingsBloc(sharedPreferences);

  final scheduleSupabaseRemoteDS = createScheduleRemoteDs(supabaseClient);

  final accountBloc = createAccountBloc(supabaseClient);

  final scheduleBloc = createScheduleBloc(
    foodService,
    scheduleSupabaseRemoteDS,
  );

  final authCubit = createAuthCubit(supabaseClient);

  final userBaseBloc = createUserBaseBloc(
    foodService,
    scheduleSupabaseRemoteDS,
  );

  final settingsBloc = createSettingsBloc(supabaseClient);

  return DependenciesContainer(
    logger: logger,
    config: config,
    errorReporter: errorReporter,
    packageInfo: packageInfo,
    accountBloc: accountBloc,
    authCubit: authCubit,
    scheduleBloc: scheduleBloc,
    userbaseBloc: userBaseBloc,
    settingsBloc: settingsBloc,
    appSettingsBloc: appSettingsBloc,
  );
}

Logger createAppLogger({List<LogObserver> observers = const []}) {
  final logger = Logger();

  for (final observer in observers) {
    logger.addObserver(observer);
  }

  return logger;
}

Future<ErrorReporter> createErrorReporter(ApplicationConfig config) async {
  final errorReporter = SentryErrorReporter(
    sentryDsn: config.sentryDsn,
    environment: config.environment.value,
  );

  if (config.sentryDsn.isNotEmpty) {
    await errorReporter.initialize();
  }

  return errorReporter;
}

ScheduleSupabaseRemoteDS createScheduleRemoteDs(SupabaseClient supabaseClient) {
  return ScheduleSupabaseRemoteDS(supabase: supabaseClient);
}

SettingsBloc createSettingsBloc(SupabaseClient supabaseClient) {
  return SettingsBloc(
    settingsRepository: SettingsRepositoryImpl(
      settingsDS: SupabaseSettingsDS(supabaseClient: supabaseClient),
    ),
  );
}

AuthCubit createAuthCubit(SupabaseClient supabaseClient) {
  return AuthCubit(supabase: supabaseClient);
}

UserbaseBloc createUserBaseBloc(
  FoodService foodService,
  ScheduleSupabaseRemoteDS scheduleSupabaseRemoteDS,
) {
  final userBaseRepository = UserBaseRepositoryImpl(
    scheduleRemoteDs: scheduleSupabaseRemoteDS,
  );
  return UserbaseBloc(userBaseRepository: userBaseRepository);
}

ScheduleBloc createScheduleBloc(
  FoodService foodService,
  ScheduleSupabaseRemoteDS scheduleSupabaseRemoteDS,
) {
  final scheduleRepo = ScheduleRepositoryImpl(
    foodService: foodService,
    scheduleRemoteDs: scheduleSupabaseRemoteDS,
  );
  return ScheduleBloc(scheduleRepository: scheduleRepo);
}

AccountBloc createAccountBloc(SupabaseClient supabaseClient) {
  final accountInitRepo = AccountInitRepositoryImpl(
    supabaseRemoteAccountDS: SupabaseRemoteAccountDS(
      supabaseClient: supabaseClient,
    ),
  );
  return AccountBloc(accountInitRepository: accountInitRepo);
}

Future<AppSettingsBloc> createAppSettingsBloc(
  SharedPreferencesAsync sharedPreferences,
) async {
  final appSettingsRepository = AppSettingsRepositoryImpl(
    datasource: AppSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
  );

  final appSettings = await appSettingsRepository.getAppSettings();
  final initialState = AppSettingsState.idle(appSettings: appSettings);

  return AppSettingsBloc(
    appSettingsRepository: appSettingsRepository,
    initialState: initialState,
  );
}
