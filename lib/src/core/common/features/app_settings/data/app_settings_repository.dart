

import 'package:naturly/src/core/common/features/app_settings/data/app_settings_datasource.dart';
import 'package:naturly/src/core/common/features/app_settings/model/app_settings.dart';

abstract interface class AppSettingsRepository {
  Future<void> setAppSettings(AppSettings appSettings);

  Future<AppSettings?> getAppSettings();
}

final class AppSettingsRepositoryImpl implements AppSettingsRepository {
  const AppSettingsRepositoryImpl({required this.datasource});

  final AppSettingsDatasource datasource;

  @override
  Future<AppSettings?> getAppSettings() => datasource.getAppSettings();

  @override
  Future<void> setAppSettings(AppSettings appSettings) =>
      datasource.setAppSettings(appSettings);
}
