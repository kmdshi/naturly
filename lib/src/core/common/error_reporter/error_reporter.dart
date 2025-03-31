import 'dart:async';

import 'package:logger/logger.dart';

abstract interface class ErrorReporter {

  bool get isInitialized;

  Future<void> initialize();

  Future<void> close();

  Future<void> captureException({required Object throwable, StackTrace? stackTrace});
}


final class ErrorReporterLogObserver with LogObserver {
  const ErrorReporterLogObserver(this._errorReporter);

  final ErrorReporter _errorReporter;

  @override
  void onLog(LogMessage logMessage) {
    if (!_errorReporter.isInitialized) return;

    if (logMessage.level.index >= LogLevel.error.index) {
      _errorReporter.captureException(
        throwable: logMessage.error ?? ReportedMessageException(logMessage.message),
        stackTrace: logMessage.stackTrace ?? StackTrace.current,
      );
    }
  }
}

class ReportedMessageException implements Exception {
  const ReportedMessageException(this.message);

  final String message;

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportedMessageException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
