import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:naturly/src/core/common/bloc/app_bloc_observer.dart';
import 'package:naturly/src/core/common/bloc/bloc_transformer.dart';
import 'package:naturly/src/core/common/error_reporter/error_reporter.dart';
import 'package:naturly/src/core/constant/application_config.dart';
import 'package:naturly/src/core/common/features/initialization/logic/composition_root.dart';
import 'package:naturly/src/core/common/features/initialization/widget/initialization_failed_app.dart';
import 'package:naturly/src/core/common/features/initialization/widget/root_context.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

sealed class AppRunner {
  const AppRunner._();

  static Future<void> startup() async {
    const config = ApplicationConfig();
    final errorReporter = await createErrorReporter(config);

    final logger = createAppLogger(
      observers: [
        ErrorReporterLogObserver(errorReporter),
        if (!kReleaseMode) const PrintingLogObserver(logLevel: LogLevel.trace),
      ],
    );

    await runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = logger.logFlutterError;
      WidgetsBinding.instance.platformDispatcher.onError =
          logger.logPlatformDispatcherError;

      await Supabase.initialize(
        url: 'https://qlcgwkwciarqszqciqul.supabase.co',
        anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFsY2d3a3djaWFycXN6cWNpcXVsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMzNDAxMjEsImV4cCI6MjA1ODkxNjEyMX0.jtSTVloa_Plm8GYLR4blFImSIuHhfYW7OyrytR2kXy8',
      );

      Bloc.observer = AppBlocObserver(logger);
      Bloc.transformer = SequentialBlocTransformer<Object?>().transform;

      Future<void> launchApplication() async {
        try {
          final compositionResult =
              await CompositionRoot(
                config: config,
                logger: logger,
                errorReporter: errorReporter,
              ).compose();

          runApp(RootContext(compositionResult: compositionResult));
        } on Object catch (e, stackTrace) {
          logger.error(
            'Initialization failed',
            error: e,
            stackTrace: stackTrace,
          );
          runApp(
            InitializationFailedApp(
              error: e,
              stackTrace: stackTrace,
              onRetryInitialization: launchApplication,
            ),
          );
        }
      }

      await launchApplication();
    }, logger.logZoneError);
  }
}
