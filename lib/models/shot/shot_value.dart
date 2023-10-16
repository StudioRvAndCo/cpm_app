import 'dart:ui';

import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ShotValue {
  full(Color(0xFFff69b4)),
  mediumFull(Color(0xFF7f0000)),
  cowboy(Color(0xFF008000)),
  medium(Color(0xFF000080)),
  mediumCloseup(Color(0xFFff8c00)),
  closeup(Color(0xFFffff00)),
  extremeCloseup(Color(0xFF00ff00)),
  insert(Color(0xFF00ffff)),
  sequence(Color(0xFFff00ff)),
  landscape(Color(0xFF1e90ff)),
  drone(Color(0xFFffdead)),
  other(Color(0xFF2f4f4f)),
  ;

  final Color color;

  String get label {
    switch (this) {
      case ShotValue.full:
        return localizations.projects_shots_value_full;
      case ShotValue.mediumFull:
        return localizations.projects_shots_value_medium_full;
      case ShotValue.cowboy:
        return localizations.projects_shots_value_cowboy;
      case ShotValue.medium:
        return localizations.projects_shots_value_medium;
      case ShotValue.mediumCloseup:
        return localizations.projects_shots_value_medium_closeup;
      case ShotValue.closeup:
        return localizations.projects_shots_value_closeup;
      case ShotValue.extremeCloseup:
        return localizations.projects_shots_value_extreme_closeup;
      case ShotValue.insert:
        return localizations.projects_shots_value_insert;
      case ShotValue.sequence:
        return localizations.projects_shots_value_sequence;
      case ShotValue.landscape:
        return localizations.projects_shots_value_landscape;
      case ShotValue.drone:
        return localizations.projects_shots_value_drone;
      case ShotValue.other:
        return localizations.projects_shots_value_other;
    }
  }

  static List<String> labels() {
    return ShotValue.values.map((value) => value.label).toList();
  }

  const ShotValue(this.color);

  factory ShotValue.fromString(String? label) {
    return ShotValue.values.firstWhere(
      (value) => value.label == label,
      orElse: () => ShotValue.other,
    );
  }
}
