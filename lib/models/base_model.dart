import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel extends Equatable {
  @JsonKey(includeToJson: false)
  final int id;

  const BaseModel({
    required this.id,
  });

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonCache();

  @override
  List<Object> get props => [id];
}
