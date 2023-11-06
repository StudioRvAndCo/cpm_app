import 'package:cpm/l10n/app_localizations.g.dart';
import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/string_extensions.dart';
import 'package:cpm/utils/locale_manager.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:cpm/utils/preferences/preference_key.dart';
import 'package:cpm/utils/preferences/preferences_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:locale_names/locale_names.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage();

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  Future<void> _logout(BuildContext context) async {
    await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(localizations.login_log_out),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(localizations.dialog_log_out),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(localizations.button_cancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(localizations.login_log_out),
            ),
          ],
        );
      },
    ).then((logout) {
      if (logout != null && logout) {
        ref.read(authenticationProvider.notifier).logout();
        context.goNamed(RouterRoute.login.name);
      }
    });
  }

  void _selectTheme(BuildContext context) {
    showAdaptiveDialog<ThemeMode>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          title: Text(localizations.settings_theme),
          children: [
            ListTile(
              leading: const Icon(Icons.smartphone),
              title: Text(localizations.settings_theme_system),
              onTap: () {
                context.pop(ThemeMode.system);
              },
            ),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(localizations.settings_theme_light),
              onTap: () {
                context.pop(ThemeMode.light);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(localizations.settings_theme_dark),
              onTap: () {
                context.pop(ThemeMode.dark);
              },
            ),
          ],
        );
      },
    ).then((themeMode) {
      ThemeManager().setThemeMode(themeMode);
      setState(() {});
    });
  }

  void _toggleDynamicTheming(bool? value) {
    if (value != null) {
      PreferencesManager().set<bool>(PreferenceKey.dynamicTheming.name, value);
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      themeModeNotifier.notifyListeners();
      setState(() {});
    }
  }

  void _selectLanguage(BuildContext context) {
    showAdaptiveDialog<Locale>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          title: Text(localizations.settings_language),
          children: AppLocalizations.supportedLocales.map((locale) {
            return ListTile(
              title: Text(locale.nativeDisplayLanguage.capitalized),
              onTap: () {
                context.pop(locale);
              },
            );
          }).toList(),
        );
      },
    ).then((locale) {
      LocaleManager().setLocale(locale);
    });
  }

  void _openStudioRvAndCo(_) {
    launchUrlString('https://rvandco.fr');
  }

  void _openGitHub(_) {
    launchUrlString('https://github.com/studiorvandco/cpm_app');
  }

  void _openLicense(_) {
    launchUrlString('https://github.com/studiorvandco/cpm_app/blob/main/LICENSE');
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).colorScheme.background,
      ),
      darkTheme: SettingsThemeData(
        settingsListBackground: Theme.of(context).colorScheme.background,
      ),
      sections: [
        SettingsSection(
          title: Text(localizations.settings_account),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.account_circle),
              title: Text(localizations.settings_user),
              value: Text(Supabase.instance.client.auth.currentUser?.email ?? ''),
            ),
            SettingsTile(
              leading: const Icon(Icons.logout),
              title: Text(localizations.settings_log_out),
              value: Text(localizations.settings_log_out_description(PackageInfoManager().name)),
              onPressed: _logout,
            ),
          ],
        ),
        SettingsSection(
          title: Text(localizations.settings_appearance),
          tiles: [
            SettingsTile.navigation(
              leading: const Icon(Icons.palette),
              title: Text(localizations.settings_theme),
              value: Text(ThemeManager().themeModeName),
              onPressed: _selectTheme,
            ),
            SettingsTile.switchTile(
              leading: const Icon(Icons.bolt),
              title: Text(localizations.settings_dynamic_theming),
              description: Text(localizations.settings_dynamic_theming_description),
              initialValue: ThemeManager().dynamicTheming,
              onToggle: _toggleDynamicTheming,
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: Text(localizations.settings_language),
              value: Text(Localizations.localeOf(context).nativeDisplayLanguage.capitalized),
              onPressed: _selectLanguage,
            ),
          ],
        ),
        SettingsSection(
          title: Text(localizations.settings_about),
          tiles: [
            SettingsTile(
              leading: const Icon(Icons.info),
              title: Text(PackageInfoManager().name),
              value: Text(PackageInfoManager().version),
            ),
            SettingsTile(
              leading: const Icon(Icons.movie),
              title: Text(localizations.settings_studiorvandco),
              value: Text(localizations.settings_studiorvandco_description),
              onPressed: _openStudioRvAndCo,
            ),
            SettingsTile(
              leading: const Icon(SimpleIcons.github),
              title: Text(localizations.settings_github),
              value: Text(localizations.settings_github_description),
              onPressed: _openGitHub,
            ),
            SettingsTile(
              leading: const Icon(Icons.balance),
              title: Text(localizations.settings_licence),
              value: Text(localizations.settings_licence_description),
              onPressed: _openLicense,
            ),
          ],
        ),
      ],
    );
  }
}
