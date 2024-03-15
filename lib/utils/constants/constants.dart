import 'package:cpm/l10n/app_localizations.g.dart';
import 'package:cpm/utils/locale_manager.dart';
import 'package:cpm/utils/theme_manager.dart';
import 'package:flutter/material.dart';

final localeNotifier = ValueNotifier<Locale>(LocaleManager().locale);
final themeModeNotifier = ValueNotifier<ThemeMode>(ThemeManager().themeMode);

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'Root navigator key');

final localizations = AppLocalizations.of(navigatorKey.currentContext!)!;
