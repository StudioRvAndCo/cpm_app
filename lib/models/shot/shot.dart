import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shot.g.dart';

@JsonSerializable()
class Shot extends BaseModel {
  int sequence;
  int index;
  @JsonKey(includeToJson: false)
  int number;
  ShotValue? value;
  String? description;
  bool completed;

  String get getNumber => number.toString();

  String get getDescription => description ?? '';

  String get getValue => value?.label ?? ShotValue.other.label;

  Shot({
    required super.id,
    required this.sequence,
    required this.index,
    required this.number,
    this.value,
    this.description,
    required this.completed,
  });

  Shot.insert({
    required this.sequence,
    required this.index,
    this.value,
    this.description,
  })  : number = -1,
        completed = false,
        super(id: -1);

  Shot.empty()
      : sequence = -1,
        index = -1,
        number = -1,
        completed = false,
        super(id: -1);

  factory Shot.fromJson(Map<String, dynamic> json) => _$ShotFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShotToJson(this);
}
