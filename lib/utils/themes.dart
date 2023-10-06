import 'package:flutter/material.dart';

class Themes {
  ThemeData light = ThemeData(
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
      onTertiary: Color(0xFF393939),
    ),
    useMaterial3: true,
  );

  ThemeData dark = ThemeData(
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
      onTertiary: Color(0xFF393939),
    ),
    useMaterial3: true,
  );
}
