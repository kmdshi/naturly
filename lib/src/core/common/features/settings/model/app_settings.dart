import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:naturly/src/core/common/features/settings/model/app_theme.dart';


class AppSettings with Diagnosticable {
  const AppSettings({this.appTheme, this.locale, this.textScale});

  final AppTheme? appTheme;

  final Locale? locale;

  final double? textScale;

  AppSettings copyWith({AppTheme? appTheme, Locale? locale, double? textScale}) => AppSettings(
    appTheme: appTheme ?? this.appTheme,
    locale: locale ?? this.locale,
    textScale: textScale ?? this.textScale,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppSettings &&
        other.appTheme == appTheme &&
        other.locale == locale &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(appTheme, locale, textScale);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<AppTheme>('appTheme', appTheme));
    properties.add(DiagnosticsProperty<Locale>('locale', locale));
    properties.add(DoubleProperty('textScale', textScale));
    super.debugFillProperties(properties);
  }
}
