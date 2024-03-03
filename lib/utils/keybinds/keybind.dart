import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

enum Keybinding {
  back(
    LogicalKeyboardKey.altLeft,
    LogicalKeyboardKey.arrowLeft,
    _pop,
  ),
  ;

  final LogicalKeyboardKey modifier;
  final LogicalKeyboardKey key;
  final Function() function;

  const Keybinding(this.modifier, this.key, this.function);

  LogicalKeySet get _logicalKeySet {
    return LogicalKeySet(modifier, key);
  }

  static void _pop() {
    final context = navigatorKey.currentContext;
    if (context != null && context.mounted && context.canPop()) context.pop();
  }

  static Map<LogicalKeySet, Function()> get asMap {
    return kIsDesktop
        ? {
            for (final keybinding in values) keybinding._logicalKeySet: keybinding.function,
          }
        : {};
  }
}
