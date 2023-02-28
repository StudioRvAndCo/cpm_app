import 'package:flutter/material.dart';

class CPMThemeLight {
  ThemeData theme = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          background: Color(0xFFFFFFFF),
          error: Color(0xFFBE0000),
          onBackground: Color(0xFF393939),
          onError: Color(0xFFFFFFFF),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFF393939),
          onSurface: Color(0xFF393939),
          primary: Color(0xFF5865F2),
          secondary: Color(0xFF9EA6FC),
          surface: Color(0xFFEFF0FF)),
      useMaterial3: true);
}
