import 'package:cpm/utils/constants_globals.dart';
import 'package:flutter/material.dart';

class SnackBarManager {
  static final SnackBarManager _instance = SnackBarManager._internal();

  factory SnackBarManager() {
    return _instance;
  }

  SnackBarManager._internal();

  void show(SnackBar snackBar) {
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}
