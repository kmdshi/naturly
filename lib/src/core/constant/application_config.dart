
import 'package:naturly/src/core/common/features/initialization/model/environment.dart';

class ApplicationConfig {
  const ApplicationConfig();

  Environment get environment {
    var env = const String.fromEnvironment('ENVIRONMENT').trim();

    if (env.isNotEmpty) {
      return Environment.from(env);
    }

    env = const String.fromEnvironment('FLUTTER_APP_FLAVOR').trim();

    return Environment.from(env);
  }

  String get sentryDsn => const String.fromEnvironment('SENTRY_DSN').trim();

  String get supabaseUrl => const String.fromEnvironment('SUPABASE_URL').trim();
  String get supabaseKey => const String.fromEnvironment('SUPABASE_KEY').trim();

  bool get enableSentry => sentryDsn.isNotEmpty;
}


base class TestConfig implements ApplicationConfig {
  const TestConfig();

  @override
  Object noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} (${invocation.runtimeType}) config option, but '
      'it was not provided. Please provide the option in the test. '
      'You can do it by extending this class and providing the option.',
    );
  }
}
