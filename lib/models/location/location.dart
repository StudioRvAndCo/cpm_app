// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends BaseModel {
  String? name;
  String? position;

  String get getName => name ?? localizations.projects_no_name;

  Location({
    required super.id,
    this.name,
    this.position,
  });

  Location.insert({
    this.name,
    this.position,
  }) : super(id: -1);

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return _$LocationToJson(this)
      ..addAll({
        'id': id,
      });
  }
}
