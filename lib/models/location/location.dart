import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends BaseModel {
  String? name;
  String? position;

  String get getName => name ?? 'Unnamed';

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
}
