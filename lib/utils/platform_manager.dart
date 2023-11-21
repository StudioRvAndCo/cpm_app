import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformManager {
  static final PlatformManager _singleton = PlatformManager._internal();

  factory PlatformManager() {
    return _singleton;
  }

  PlatformManager._internal();

  bool get isMobile {
    if (kIsWeb) {
      return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
    } else {
      return Platform.isAndroid || Platform.isIOS;
    }
  }

  bool get isDesktop {
    if (isWeb) return false;

    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  bool get isWeb {
    return kIsWeb;
  }

  bool get isAndroid {
    return kIsWeb ? defaultTargetPlatform == TargetPlatform.android : Platform.isAndroid;
  }
}
