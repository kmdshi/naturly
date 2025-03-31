import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:naturly/src/core/common/error_reporter/error_reporter.dart';


class SentryErrorReporter implements ErrorReporter {
  const SentryErrorReporter({required this.sentryDsn, required this.environment});

  final String sentryDsn;

  final String environment;

  @override
  bool get isInitialized => Sentry.isEnabled;

  @override
  Future<void> initialize() async {
    await SentryFlutter.init(
      (options) =>
          options
            ..dsn = sentryDsn
            ..tracesSampleRate = 0.10
            ..debug = kDebugMode
            ..environment = environment
            ..anrEnabled = true
            ..sendDefaultPii = true,
    );
  }

  @override
  Future<void> close() async {
    await Sentry.close();
  }

  @override
  Future<void> captureException({required Object throwable, StackTrace? stackTrace}) async {
    await Sentry.captureException(throwable, stackTrace: stackTrace);
  }
}
