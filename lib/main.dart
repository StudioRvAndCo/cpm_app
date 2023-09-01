import 'package:cpm/utils/config/config_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'cpm.dart';
import 'utils/config/config.dart';

void main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning];
  await Config().init();
  await Supabase.initialize(
    url: Config().get<String>(ConfigKey.supabaseUrl),
    anonKey: Config().get<String>(ConfigKey.supabaseAnonKey),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      path: 'assets/translations',
      child: const ProviderScope(child: CPM()),
    ),
  );
}
