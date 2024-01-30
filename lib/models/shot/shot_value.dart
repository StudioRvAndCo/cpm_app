import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ShotValue {
  extremeCloseup(0),
  closeup(1),
  mediumCloseup(2),
  medium(3),
  cowboy(4),
  mediumFull(5),
  full(6),
  landscape(7),
  drone(8),
  sequence(9),
  insert(10),
  other(17),
  ;

  /// Index of the color in the [Colors.primaries] array
  final int colorIndex;

  static List<String> labels() {
    return ShotValue.values.map((value) => value.label).toList();
  }

  const ShotValue(this.colorIndex);

  factory ShotValue.fromName(String? name) {
    return ShotValue.values.firstWhere(
      (value) => value.name == name,
      orElse: () => ShotValue.other,
    );
  }

  Color get color {
    return Colors.primaries[colorIndex].shade700;
  }

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
}
