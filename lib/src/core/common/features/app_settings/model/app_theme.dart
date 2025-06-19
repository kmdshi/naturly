import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTheme with Diagnosticable {
  const AppTheme({required this.themeMode});

  final ThemeMode themeMode;

  // final Color seed;

  // static const defaultTheme = AppTheme(
  // themeMode: ThemeMode.system,
  // seed: Color(0xFF6200EE),
  // );

  ThemeData buildThemeData(Brightness brightness) {
    // final colorScheme = ColorScheme.fromSeed(
    //   seedColor: seed,
    //   brightness: brightness,
    // );
    return ThemeData(
      scaffoldBackgroundColor:
          brightness == Brightness.light ? Color(0xFFF9F7F4) : Colors.grey,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,

        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', themeMode));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && themeMode == other.themeMode;
}
