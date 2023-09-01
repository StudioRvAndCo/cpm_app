import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sequence_location.g.dart';

@JsonSerializable()
class SequenceLocation extends BaseModel {
  final int sequence;
  final int location;

  const SequenceLocation({
    required super.id,
    required this.sequence,
    required this.location,
  });

  SequenceLocation.insert({
    required this.sequence,
    required this.location,
  }) : super(id: -1);

  factory SequenceLocation.fromJson(Map<String, dynamic> json) => _$SequenceLocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SequenceLocationToJson(this);
}
