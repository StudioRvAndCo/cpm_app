// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends BaseModel {
  int? project;
  String? title;
  String? description;
  String? director;
  String? writer;
  @JsonKey(includeToJson: false)
  int? shotsTotal;
  @JsonKey(includeToJson: false)
  int? shotsCompleted;

  Episode({
    super.id,
    super.index,
    this.project,
    this.title,
    this.description,
    this.director,
    this.writer,
    this.shotsTotal,
    this.shotsCompleted,
  });

  factory Episode.moviePlaceholder(int projectId) => Episode(
        project: projectId,
        index: LexoRanker().newRank(),
      );

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  String get getTitle {
    return title == null || title!.isEmpty ? localizations.projects_no_title : title!;
  }

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  double get progress {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return 0.0;
    }

    return shotsCompleted! / shotsTotal!;
  }

  String get progressText {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return '-/-';
    }

    return '$shotsCompleted/$shotsTotal';
  }

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this)
    ..addAll({
      'index': index,
    });

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(
      _$EpisodeToJson(this)
        ..addAll({
          'shots_total': shotsTotal,
          'shots_completed': shotsCompleted,
        }),
    );
  }
}
