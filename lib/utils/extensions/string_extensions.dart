import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get capitalized {
    return toBeginningOfSentenceCase(this) ?? this;
  }

  bool get isBlank {
    return trim().isEmpty;
  }

  bool get isNotBlank {
    return trim().isNotEmpty;
  }
}
