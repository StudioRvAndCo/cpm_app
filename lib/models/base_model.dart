import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel {
  @JsonKey(includeToJson: false)
  final int id;

  const BaseModel({required this.id});

  Map<String, dynamic> toJson();
}
