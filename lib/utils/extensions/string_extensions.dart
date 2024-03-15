import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get capitalized {
    return toBeginningOfSentenceCase(this) ?? this;
  }
}
