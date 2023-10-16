import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ShotValue {
  full('full', Color(0xFFff69b4)),
  mediumFull('medium_full', Color(0xFF7f0000)),
  cowboy('cowboy', Color(0xFF008000)),
  medium('medium', Color(0xFF000080)),
  mediumCloseup('medium_closeup', Color(0xFFff8c00)),
  closeup('closeup', Color(0xFFffff00)),
  extremeCloseup('extreme_closeup', Color(0xFF00ff00)),
  insert('insert', Color(0xFF00ffff)),
  sequence('sequence', Color(0xFFff00ff)),
  landscape('landscape', Color(0xFF1e90ff)),
  drone('drone', Color(0xFFffdead)),
  other('other', Color(0xFF2f4f4f)),
  ;

  final String _name;
  final Color color;

  String get label => 'attributes.values.$_name';

  static List<String> labels() => ShotValue.values.map((value) => value.label).toList();

  const ShotValue(this._name, this.color);

  factory ShotValue.fromString(String? label) {
    return ShotValue.values.firstWhere(
      (value) => value.label == label,
      orElse: () => ShotValue.other,
    );
  }
}
