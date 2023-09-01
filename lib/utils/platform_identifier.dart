import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// Identifies the platform the app is running on.
class PlatformIdentifier {
  static final PlatformIdentifier _instance = PlatformIdentifier._internal();

  factory PlatformIdentifier() {
    return _instance;
  }

  PlatformIdentifier._internal();

  /// Whether the platform is a computer.
  ///
  /// Desktop app or running in a desktop web browser.
  bool isComputer() {
    return kIsWeb
        ? defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS
        : Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  /// Whether the platform is not a computer.
  ///
  /// Native mobile app or running in a mobile web browser.
  bool isNotComputer() {
    return !isComputer();
  }
}
