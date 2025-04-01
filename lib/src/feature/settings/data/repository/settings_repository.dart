// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:naturly/src/feature/settings/data/datasources/supabase_settings_ds.dart';
import 'package:naturly/src/feature/settings/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SupabaseSettingsDS settingsDS;
  SettingsRepositoryImpl({required this.settingsDS});
  @override
  Future<void> logOut() async {
    await settingsDS.logOut();
  }
}
