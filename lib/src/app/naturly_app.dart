import 'package:flutter/material.dart';
import 'package:naturly/src/core/router/routes.dart';

class NaturlyApp extends StatefulWidget {
  @override
  State<NaturlyApp> createState() => _NaturlyAppState();
}

class _NaturlyAppState extends State<NaturlyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
