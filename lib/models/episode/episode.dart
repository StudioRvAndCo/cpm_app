// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends BaseModel {
  int project;
  int index;
  @JsonKey(includeToJson: false)
  int number;
  String? title;
  String? description;
  String? director;
  String? writer;

  String get getTitle => title ?? 'Untitled';

  String get getDescription => description ?? '';

  String get getNumber => number.toString();

  Episode({
    required super.id,
    required this.project,
    required this.index,
    required this.number,
    this.title,
    this.description,
    this.director,
    this.writer,
  });

  Episode.insert({
    required this.project,
    required this.index,
    this.title,
    this.description,
    this.director,
    this.writer,
  })  : number = -1,
        super(id: -1);

  Episode.empty()
      : project = -1,
        index = -1,
        number = -1,
        super(id: -1);

  Episode.movie({required this.project})
      : index = -1,
        number = -1,
        super(id: -1);

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return _$EpisodeToJson(this)
      ..addAll({
        'id': id,
        'number': number,
      });
  }
}
