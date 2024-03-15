import 'package:cpm/app.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:cpm/utils/env/env.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:cpm/utils/preferences/preferences_manager.dart';
import 'package:cpm/utils/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // ignore: depend_on_referenced_packages
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await PreferencesManager().init();
  await PackageInfoManager().init();
  await ThemeManager().init();
  await CacheManager().init();
  await Favorites().init();

  usePathUrlStrategy();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
  );

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
