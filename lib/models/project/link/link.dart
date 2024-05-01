// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends BaseModel {
  int? project;
  String? label;
  String? url;

  Link({
    super.id,
    super.index,
    this.project,
    this.label,
    this.url,
  });

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  String get getLabel {
    return label == null || label!.isEmpty ? '' : label!;
  }

  String get getUrl {
    return url == null || url!.isEmpty ? '' : url!;
  }

  @override
  Map<String, dynamic> toJson() => _$LinkToJson(this)
    ..addAll({
      'index': index,
    });

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(_$LinkToJson(this));
  }
}
