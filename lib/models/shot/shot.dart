// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shot.g.dart';

@JsonSerializable()
class Shot extends BaseModel {
  int? sequence;
  int? index;
  @JsonKey(includeToJson: false)
  int? number;
  ShotValue? value;
  String? description;
  bool completed;

  Shot({
    super.id,
    this.sequence,
    this.index,
    this.number,
    this.value,
    this.description,
    this.completed = false,
  });

  factory Shot.fromJson(Map<String, dynamic> json) => _$ShotFromJson(json);

  String get getNumber => number.toString();

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  String get getValue => value?.label ?? localizations.projects_no_value;

  @override
  Map<String, dynamic> toJson() => _$ShotToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(
      _$ShotToJson(this)
        ..addAll({
          'number': number,
        }),
    );
  }
}
