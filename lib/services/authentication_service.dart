import 'package:cpm/services/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService extends Service {
  bool get isAuthenticated {
    return supabase.auth.currentSession != null;
  }

  Future<bool> login(String email, String password) async {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return response.session != null;
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
