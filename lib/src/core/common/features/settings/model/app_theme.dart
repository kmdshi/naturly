import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTheme with Diagnosticable {
  const AppTheme({required this.themeMode});

  final ThemeMode themeMode;

  // final Color seed;

  static const defaultTheme = AppTheme(themeMode: ThemeMode.system);

  ThemeData buildThemeData(Brightness brightness) {
    return ThemeData(
      scaffoldBackgroundColor:
          brightness == Brightness.light ? Color(0xFFF8FAFB) : Colors.grey,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor:
            brightness == Brightness.light ? Colors.red : Colors.black,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<ThemeMode>('type', themeMode));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme && themeMode == other.themeMode;
}
