// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sequence_location.g.dart';

@JsonSerializable()
class SequenceLocation extends BaseModel {
  final int sequence;
  final int location;

  SequenceLocation({
    super.id,
    required this.sequence,
    required this.location,
  });

  factory SequenceLocation.fromJson(Map<String, dynamic> json) => _$SequenceLocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SequenceLocationToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(_$SequenceLocationToJson(this));
  }
}
