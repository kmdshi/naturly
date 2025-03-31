import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTheme with Diagnosticable {
  const AppTheme({required this.themeMode, required this.seed});

  final ThemeMode themeMode;

  final Color seed;

  static const defaultTheme =
      AppTheme(themeMode: ThemeMode.system, seed: Color(0xFF6200EE));

  ThemeData buildThemeData(Brightness brightness) {
    final colorScheme =
        ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
    return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', themeMode));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && seed == other.seed && themeMode == other.themeMode;

  @override
  int get hashCode => Object.hash(seed, themeMode);
}
