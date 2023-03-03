import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart' if (dart.library.html) 'package:intl/intl_browser.dart';

import 'routes/route.gr.dart';
import 'services/login.dart';
import 'theme.dart';

// TODO(mael): create certificate
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
  runApp(CPM());
}

final LoginState loginState = LoginState();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class LoginState extends ChangeNotifier {
  bool authenticated = false;
  String apiToken = '';
  int statusCode = 0;
  String reasonPhrase = '';

  Future<void> login(String username, String password) async {
    final List<dynamic> result = await LoginService().login(username, password);
    authenticated = result[0] as bool;
    apiToken = result[1] as String;
    statusCode = result[2] as int;
    reasonPhrase = result[3] as String;
    notifyListeners();
  }

  Future<void> logout() async {
    authenticated = false;
    apiToken = '';
    statusCode = 0;
    reasonPhrase = '';
    notifyListeners();
  }
}

class CPM extends StatefulWidget {
  CPM({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  State<CPM> createState() => _CPMState();
}

class _CPMState extends State<CPM> {
  @override
  void initState() {
    super.initState();
    loginState.addListener(() => setState(() {}));
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp.router(
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
          theme: CPMThemeLight().theme),
    );
  }

  Future<void> _handleLogin(String username, String password) async {
    loginState.login(username, password).then((void value) {
      if (loginState.statusCode != 200 && scaffoldMessengerKey.currentContext != null) {
        ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!).showSnackBar(LoginSnackBar().generateSnackBar());
      }
    });
  }
}
