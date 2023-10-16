import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  TimeOfDay get hourLater {
    return replacing(hour: hour + 1, minute: minute);
  }
}
