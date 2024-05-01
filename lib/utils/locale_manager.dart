import 'dart:io';

import 'package:cpm/l10n/app_localizations.g.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/preferences/preference_key.dart';
import 'package:cpm/utils/preferences/preferences_manager.dart';
import 'package:cpm/utils/snack_bar_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleManager {
  Locale get locale {
    final preferredLocaleLanguageCode = PreferencesManager().get<String>(PreferenceKey.locale);

    if (preferredLocaleLanguageCode != null) {
      return Locale(preferredLocaleLanguageCode);
    } else {
      if (kIsWeb) {
        return const Locale('en');
      }

      final deviceLocale = Platform.localeName;
      for (final locale in AppLocalizations.supportedLocales) {
        if (deviceLocale.split('_').first == locale.languageCode) {
          return locale;
        }
      }

      return const Locale('en');
    }
  }

  void setLocale(Locale? locale) {
    if (locale == null) {
      return;
    }

    PreferencesManager().set(PreferenceKey.locale.name, locale.languageCode);

    SnackBarManager.info(localizations.settings_language_restart).show();
  }
}
