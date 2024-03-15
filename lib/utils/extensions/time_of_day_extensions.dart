import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  TimeOfDay get hourLater {
    if (hour == 23) {
      return const TimeOfDay(hour: 0, minute: 0);
    }

    return replacing(hour: hour + 1, minute: minute);
  }
}
