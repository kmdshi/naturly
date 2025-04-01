// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSettingsDS {
  final SupabaseClient supabaseClient;
  SupabaseSettingsDS({required this.supabaseClient});
  Future<void> logOut() async {
    await supabaseClient.auth.signOut();
  }
}
