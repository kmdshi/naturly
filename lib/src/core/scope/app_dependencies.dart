import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  const AppDependencies({
    super.key,
    required super.child,
  });

  static AppDependencies of(BuildContext context) {
    final AppDependencies? result =
        context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'No AppDependencies found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AppDependencies oldWidget) => false;
}
