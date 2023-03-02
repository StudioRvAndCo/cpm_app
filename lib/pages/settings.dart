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
    return SingleChildScrollView(
      child: Consumer<ModelTheme>(builder:
          (BuildContext context, ModelTheme themeNotifier, Widget? child) {
        return Column(
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
            Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: themeNotifier.themeMode,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    if (value != null) {
                      themeNotifier.themeMode = ThemeMode.system;
                    }
                  });
                })
          ],
        );
      }),
    );
  }
}
