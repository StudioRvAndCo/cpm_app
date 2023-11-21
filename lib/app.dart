import 'package:cpm/l10n/app_localizations.g.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/keybinds/keybind.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router.dart';
import 'package:cpm/utils/theme_manager.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return ValueListenableBuilder(
          valueListenable: localeNotifier,
          builder: (context, locale, child) {
            return ValueListenableBuilder(
              valueListenable: themeModeNotifier,
              builder: (context, themeMode, child) {
                final useDynamicTheming = ThemeManager().useDynamicTheming;

                return CallbackShortcuts(
                  bindings: PlatformManager().isDesktop
                      ? {
                          for (final keybinding in Keybinding.values) keybinding.logicalKeySet: keybinding.function,
                        }
                      : {},
                  child: MaterialApp.router(
                    title: PackageInfoManager().name,
                    theme: useDynamicTheming
                        ? ThemeManager().getLightDynamicTheme(lightDynamic)
                        : ThemeManager().getLightCustomTheme,
                    darkTheme: useDynamicTheming
                        ? ThemeManager().getDarkDynamicTheme(darkDynamic)
                        : ThemeManager().getDarkCustomTheme,
                    themeMode: themeMode,
                    localizationsDelegates: AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale: locale,
                    routerConfig: router,
                    debugShowCheckedModeBanner: false,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
