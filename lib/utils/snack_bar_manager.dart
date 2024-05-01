import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class SnackBarManager {
  SnackBarManager.info(String message) : text = message;

  SnackBarManager.error(String error) : text = '${localizations.error_error}: $error';

  final String text;

  void show() {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}
