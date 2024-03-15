// ignore_for_file: non_constant_identifier_names

import 'package:cpm/utils/constants/constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get Hm {
    return DateFormat.Hm(localizations.localeName).format(this);
  }

  String get yMd {
    return DateFormat.yMd(localizations.localeName).format(this);
  }

  DateTime get hundredYearsBefore {
    return subtract(const Duration(days: 36500));
  }

  DateTime get weekLater {
    return add(const Duration(days: 7));
  }

  DateTime get hundredYearsLater {
    return add(const Duration(days: 36500));
  }
}
