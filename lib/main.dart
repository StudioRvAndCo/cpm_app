import 'package:auto_route/auto_route.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/route.gr.dart';
import 'services/config.dart';
import 'services/login.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.init();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(supportedLocales: const <Locale>[
      Locale('en', 'US'),
      Locale('fr', 'FR')
    ], path: 'assets/translations', child: CPM()),
  );
}

final LoginState loginState = LoginState();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(builder:
            (BuildContext context, ModelTheme themeNotifier, Widget? child) {
          return CalendarControllerProvider(
            controller: EventController(),
            child: MaterialApp.router(
              routerDelegate: AutoRouterDelegate.declarative(
                widget._appRouter,
                routes: (_) => <PageRouteInfo<dynamic>>[
                  if (true) //TODO: loginState.authenticated
                    const HomeRoute()
                  else
                    LoginRoute(
                      onLogin: _handleLogin,
                    ),
                ],
              ),
              routeInformationParser: widget._appRouter
                  .defaultRouteParser(includePrefixMatches: true),
              title: 'CPM',
              theme: CPMThemeLight().theme,
              darkTheme: CPMThemeDark().theme,
              themeMode: themeNotifier.themeMode,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ),
          );
        }));
  }

  Future<void> _handleLogin(String username, String password) async {
    loginState.login(username, password).then((void value) {
      if (loginState.statusCode != 200 &&
          scaffoldMessengerKey.currentContext != null) {
        ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!)
            .showSnackBar(LoginSnackBar().generateSnackBar(context));
      }
    });
  }
}
