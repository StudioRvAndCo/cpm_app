// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends BaseModel {
  int? project;
  int? index;
  @JsonKey(includeToJson: false)
  int? number;
  String? title;
  String? description;
  String? director;
  String? writer;

  Episode({
    super.id,
    this.project,
    this.index,
    this.number,
    this.title,
    this.description,
    this.director,
    this.writer,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  String get getNumber => number.toString();

  String get getTitle {
    return title == null || title!.isEmpty ? localizations.projects_no_title : title!;
  }

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(
      _$EpisodeToJson(this)
        ..addAll({
          'number': number,
        }),
    );
  }
}
