import 'dart:io';

import 'package:cpm/routes/route.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

import 'theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  Intl.systemLocale = await findSystemLocale();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: widget._appRouter.delegate(),
        routeInformationParser: widget._appRouter.defaultRouteParser(),
        title: 'CPM',
        theme: CPMThemeLight().theme);
  }
}
