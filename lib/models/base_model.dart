// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

abstract class BaseModel extends Equatable {
  int? _id;

  BaseModel({int? id}) {
    _id = id;
  }

  @JsonKey(name: 'id', includeFromJson: true, includeToJson: false)
  int get id => _id ?? -1;

  String get getId => id.toString();

  int compareIds(int otherId) => id.compareTo(otherId);

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonCacheBase(Map<String, dynamic> json) {
    return json
      ..addAll({
        'id': id,
      });
  }

  Map<String, dynamic> toJsonCache();

  @override
  List<Object> get props => [id];
}
