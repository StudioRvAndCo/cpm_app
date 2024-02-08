import 'dart:ui';

import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

final scrollBehavior = ScrollConfiguration.of(navigatorKey.currentContext!).copyWith(
  dragDevices: {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  },
);

int getColumnsCount(BoxConstraints constraints) {
  if (constraints.maxWidth < 750) {
    return 1;
  } else if (constraints.maxWidth < 1500) {
    return 2;
  } else {
    return 3;
  }
}
