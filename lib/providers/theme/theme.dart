import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants_globals.dart';

part 'theme.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  FutureOr<ThemeMode> build() {
    return get();
  }

  Future<ThemeMode> get() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int index = preferences.getInt(Preferences.theme.name) ?? 0;

    return ThemeMode.values[index];
  }

  Future<void> set(ThemeMode? newMode) async {
    newMode = newMode ?? ThemeMode.system;
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(Preferences.theme.name, newMode.index);
    state = AsyncData<ThemeMode>(newMode);
  }
}
