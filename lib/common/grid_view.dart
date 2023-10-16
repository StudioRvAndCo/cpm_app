import 'package:flutter/material.dart';

int getColumnsCount(BoxConstraints constraints) {
  if (constraints.maxWidth < 750) {
    return 1;
  } else if (constraints.maxWidth < 1500) {
    return 2;
  } else {
    return 3;
  }
}
