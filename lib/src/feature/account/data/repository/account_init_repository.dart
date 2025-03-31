
import 'package:naturly/src/feature/account/data/data_source/remote/supabase_account_ds.dart';
import 'package:naturly/src/feature/account/domain/repository/account_init_repository.dart';

class AccountInitRepositoryImpl extends AccountInitRepository {
  final SupabaseRemoteAccountDS supabaseRemoteAccountDS;

  AccountInitRepositoryImpl({required this.supabaseRemoteAccountDS});

  @override
  Future<void> signIn(String email, String password) {
    return supabaseRemoteAccountDS.signInWithEmailPassword(email, password);
  }

  @override
  Future<void> signUp(String email, String password) {
    return supabaseRemoteAccountDS.signUpWithEmailPassword(email, password);
  }
}
