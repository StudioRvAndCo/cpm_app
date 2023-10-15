import 'package:cpm/pages/home.dart';
import 'package:cpm/pages/login.dart';
import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/providers/theme/theme.dart';
import 'package:cpm/utils/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CPM extends ConsumerWidget {
  const CPM({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(themeProvider).when(
      data: (ThemeMode theme) {
        FlutterNativeSplash.remove();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ref.watch(authenticationProvider).when(
            data: (bool authenticated) {
              return authenticated ? const Home() : const Login();
            },
            error: (Object error, StackTrace stackTrace) {
              return const Login();
            },
            loading: () {
              return const Login();
            },
          ),
          title: 'Cinema Project Manager',
          theme: Themes().light,
          darkTheme: Themes().dark,
          themeMode: theme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Container();
      },
      loading: () {
        return Container();
      },
    );
  }
}
