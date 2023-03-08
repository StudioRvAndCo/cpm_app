import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CPMThemeLight {
  ThemeData theme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: Color(0xFFFFFFFF),
          error: Color(0xFFBE0000),
          onBackground: Color(0xFF393939),
          onError: Color(0xFF393939),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF393939),
          onSurface: Color(0xFF393939),
          primary: Color(0xFF5865F2),
          secondary: Color(0xFF9EA6FC),
          surface: Color(0xFFEFF0FF),
          tertiary: Color(0xFFBFBFDF),
          onTertiary: Color(0xFF393939)),
      useMaterial3: true);
}

class CPMThemeDark {
  ThemeData theme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          background: Color(0xFF313338),
          error: Color(0xFFBE0000),
          onBackground: Color(0xFFFFFFFF),
          onError: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF383838),
          onSurface: Color(0xFFDDDDDD),
          primary: Color(0xFF5865F2),
          secondary: Color(0xFF9EA6FC),
          surface: Color(0xFF383A40),
          tertiary: Color(0xFFBFBFDF),
          onTertiary: Color(0xFF393939)),
      useMaterial3: true);
}

class MyThemePreferences {
  static const String THEMEOPTION_KEY = 'themeoption_key';

  Future<void> setThemeOption(ThemeMode value) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(THEMEOPTION_KEY, value.index);
  }

  Future<ThemeMode> getThemeOption() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final int? result = sharedPreferences.getInt(THEMEOPTION_KEY);
    if (result == null) {
      return ThemeMode.system;
    } else {
      return ThemeMode.values[result];
    }
  }
}

class ModelTheme extends ChangeNotifier {
  ModelTheme() {
    _themeMode = ThemeMode.light;
    _preferences = MyThemePreferences();
    getPreferences();
  }

  late ThemeMode _themeMode;
  late MyThemePreferences _preferences;
  ThemeMode get themeMode => _themeMode;

// Switching the themes
  set themeMode(ThemeMode value) {
    _themeMode = value;
    _preferences.setThemeOption(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _themeMode = await _preferences.getThemeOption();
    notifyListeners();
  }
}
