import 'dart:async';
import 'dart:developer';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/authentication_service.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication.g.dart';

@riverpod
class Authentication extends _$Authentication with BaseProvider {
  @override
  FutureOr<bool> build() {
    return authenticationService.isAuthenticated;
  }

  Future<bool> login(String email, String password) async {
    bool logged = false;
    try {
      logged = await authenticationService.login(email, password);
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
      log(exception.toString(), stackTrace: stackTrace);
    }
    state = AsyncValue<bool>.data(logged);

    return logged;
  }

  Future<void> logout() async {
    await CacheManager().clear();
    await AuthenticationService().logout();
    state = const AsyncValue<bool>.data(false);
  }
}
