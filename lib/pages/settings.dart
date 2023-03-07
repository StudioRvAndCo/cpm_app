import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(builder: (BuildContext context, ModelTheme themeNotifier, Widget? child) {
      return Expanded(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text('settings.settings'.tr(),
                textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const Padding(padding: EdgeInsets.only(bottom: 32)),
            Text('settings.theme.theme'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const Padding(padding: EdgeInsets.only(bottom: 7)),
            Text('settings.theme.description'.tr(), textAlign: TextAlign.center),
            const Padding(padding: EdgeInsets.only(bottom: 7)),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Radio<ThemeMode>(
                          value: ThemeMode.light,
                          groupValue: themeNotifier.themeMode,
                          onChanged: (ThemeMode? value) {
                            setState(() {
                              if (value != null) {
                                themeNotifier.themeMode = ThemeMode.light;
                              }
                            });
                          }),
                      Text('settings.theme.light'.tr())
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Radio<ThemeMode>(
                          value: ThemeMode.dark,
                          groupValue: themeNotifier.themeMode,
                          onChanged: (ThemeMode? value) {
                            setState(() {
                              if (value != null) {
                                themeNotifier.themeMode = ThemeMode.dark;
                              }
                            });
                          }),
                      Text('settings.theme.dark'.tr())
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: <Widget>[
                      Radio<ThemeMode>(
                          value: ThemeMode.system,
                          groupValue: themeNotifier.themeMode,
                          onChanged: (ThemeMode? value) {
                            setState(() {
                              if (value != null) {
                                themeNotifier.themeMode = ThemeMode.system;
                              }
                            });
                          }),
                      Text('settings.theme.system'.tr())
                    ],
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 32)),
            Text('settings.language.language'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            const Padding(padding: EdgeInsets.only(bottom: 7)),
            Text('settings.language.description'.tr(), textAlign: TextAlign.center),
            const Padding(padding: EdgeInsets.only(bottom: 14)),
            SizedBox(
              width: 330,
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                hint: Text('settings.language.language'.tr()),
                items: context.supportedLocales.map<DropdownMenuItem<String>>((Locale value) {
                  return DropdownMenuItem<String>(
                    value: value.toLanguageTag(),
                    child: Text('settings.language.${value.toLanguageTag()}'.tr()),
                  );
                }).toList(),
                value: context.locale.toLanguageTag(),
                onChanged: (String? value) {
                  setState(() {
                    final List<String> list = value!.split('-');
                    context.setLocale(Locale(list[0], list[1]));
                  });
                },
                decoration: InputDecoration(
                    labelText: 'settings.language.language'.tr(), border: const OutlineInputBorder(), isDense: true),
              ),
            ),
          ],
        )),
      );
    });
  }
}
