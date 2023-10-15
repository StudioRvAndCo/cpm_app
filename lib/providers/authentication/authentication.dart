import 'dart:async';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication with BaseProvider {
  @override
  FutureOr<bool> build() {
    return authenticationService.isAuthenticated();
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading<bool>();

    bool logged;
    try {
      logged = await authenticationService.login(email, password);
    } catch (_) {
      logged = false;
    }
    state = AsyncValue<bool>.data(logged);

    return logged;
  }

  Future<void> logout() async {
    await AuthenticationService().logout();
    state = const AsyncValue<bool>.data(false);
  }
}
