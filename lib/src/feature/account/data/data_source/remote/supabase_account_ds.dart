import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRemoteAccountDS {
  final SupabaseClient supabaseClient;

  const SupabaseRemoteAccountDS({required this.supabaseClient});
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    final response = await supabaseClient.auth.signUp(
      email: email,
      password: password,
    );
    return response;
  }
}
