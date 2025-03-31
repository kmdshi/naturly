import 'package:clock/clock.dart';
import 'package:flutter/foundation.dart';

base class Logger {
  Logger();

  final _observers = <LogObserver>{};

  @mustCallSuper
  void log(LogMessage logMessage) {
    if (destroyed) return;

    notifyObservers(logMessage);
  }

  void trace(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.trace,
    error: error,
    stackTrace: stackTrace,
  );

  void debug(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.debug,
    error: error,
    stackTrace: stackTrace,
  );

  void info(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.info,
    error: error,
    stackTrace: stackTrace,
  );

  void warn(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.warn,
    error: error,
    stackTrace: stackTrace,
  );

  void error(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.error,
    error: error,
    stackTrace: stackTrace,
  );

  void fatal(String message, {Object? error, StackTrace? stackTrace}) => _log(
    message: message,
    level: LogLevel.fatal,
    error: error,
    stackTrace: stackTrace,
  );

  void _log({
    required String message,
    required LogLevel level,
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    LogMessage(
      message: message,
      level: level,
      error: error,
      stackTrace: stackTrace,
      timestamp: clock.now(),
    ),
  );

  void logZoneError(Object error, StackTrace stackTrace) {
    this.error('Zone error', error: error, stackTrace: stackTrace);
  }

  void logFlutterError(FlutterErrorDetails details) {
    error('Flutter Error', error: details.exception, stackTrace: details.stack);
  }

  bool logPlatformDispatcherError(Object error, StackTrace stackTrace) {
    this.error('Platform Error', error: error, stackTrace: stackTrace);

    return true;
  }

  void addObserver(LogObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(LogObserver observer) {
    _observers.remove(observer);
  }

  void notifyObservers(LogMessage logMessage) {
    for (final observer in _observers) {
      observer.onLog(logMessage);
    }
  }

  bool get destroyed => _destroyed;
  var _destroyed = false;

  @mustCallSuper
  Future<void> destroy() async {
    _destroyed = true;
  }
}

enum LogLevel implements Comparable<LogLevel> {
  trace._(),

  debug._(),

  info._(),

  warn._(),

  error._(),

  fatal._();

  const LogLevel._();

  @override
  int compareTo(LogLevel other) => index - other.index;

  String toShortName() => switch (this) {
    LogLevel.trace => 'TRC',
    LogLevel.debug => 'DBG',
    LogLevel.info => 'INF',
    LogLevel.warn => 'WRN',
    LogLevel.error => 'ERR',
    LogLevel.fatal => 'FTL',
  };
}

mixin class LogObserver {
  const LogObserver();

  void onLog(LogMessage logMessage) {}
}

class LogMessage {
  const LogMessage({
    required this.message,
    required this.level,
    required this.timestamp,
    this.error,
    this.stackTrace,
  });

  final String message;

  final LogLevel level;

  final DateTime timestamp;

  final Object? error;

  final StackTrace? stackTrace;
}
