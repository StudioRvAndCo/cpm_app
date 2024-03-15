// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends BaseModel {
  String? name;
  String? position;

  Location({
    super.id,
    this.name,
    this.position,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  String get getName => name == null || name!.isEmpty ? localizations.projects_no_name : name!;

  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(_$LocationToJson(this));
  }
}
