import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:naturly/src/core/l10n/app_localizations.dart';


final class Localization {
  const Localization._({required this.locale});

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;

  static const _delegate = AppLocalizations.delegate;

  static List<LocalizationsDelegate<void>> get localizationDelegates => [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    _delegate,
  ];

  static Localization? get current => _current;

  static Localization? _current;

  final Locale locale;

  static Locale computeDefaultLocale() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;

    if (_delegate.isSupported(locale)) return locale;

    return const Locale('en');
  }

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context) ?? (throw FlutterError('No Localization found in context'));
}
