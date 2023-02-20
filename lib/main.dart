import 'package:flutter/material.dart';
import 'package:sandbox_frontend/pages/login_page.dart';
import 'package:sandbox_frontend/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Frontend sandbox',
        theme: CPMThemeLight().theme,
        home: const LoginPage());
  }
}
