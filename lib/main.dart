import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

import 'routes/route.gr.dart';
import 'services/login.dart';
import 'theme.dart';

// TODO create certificate
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

final LoginState loginState = LoginState();

class LoginState extends ChangeNotifier {
  bool authenticated = false;

  Future<void> login(String username, String password) async {
    authenticated = await LoginService().login(username, password);
    print(authenticated);
    notifyListeners();
  }

  Future<void> logout() async {
    authenticated = false;
    notifyListeners();
  }
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
    loginState.addListener(() => setState(() {}));
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: AutoRouterDelegate.declarative(
          widget._appRouter,
          routes: (_) => <PageRouteInfo<dynamic>>[
            if (loginState.authenticated)
              const HomeRoute()
            else
              LoginRoute(
                onLogin: _handleLogin,
              ),
          ],
        ),
        routeInformationParser: widget._appRouter.defaultRouteParser(includePrefixMatches: true),
        title: 'CPM',
        theme: CPMThemeLight().theme);
  }

  Future<void> _handleLogin(String username, String password) async {
    await loginState.login(username, password);
  }
}
