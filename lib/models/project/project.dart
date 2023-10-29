// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/project/link.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project extends BaseModel implements Comparable<Project> {
  ProjectType projectType;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? director;
  String? writer;

  @JsonKey(includeFromJson: false, includeToJson: false)
  int? shotsTotal;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? shotsCompleted;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Link>? links;

  String get getId => id.toString();

  String get getTitle => title ?? localizations.projects_no_title;

  String get getDescription => description ?? localizations.projects_no_description;

  DateTime get getStartDate => startDate ?? DateTime.now();

  DateTime get getEndDate => endDate ?? DateTime.now();

  bool get isMovie {
    return projectType == ProjectType.movie;
  }

  double get progress {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return 0.0;
    }

    return shotsCompleted! / shotsTotal!;
  }

  String? get progressText {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return null;
    }

    return '$shotsCompleted/$shotsTotal';
  }

  Project({
    required super.id,
    required this.projectType,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.shotsTotal,
    this.shotsCompleted,
    this.director,
    this.writer,
    this.links = const [],
  });

  Project.insert({
    required this.projectType,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.shotsTotal,
    this.shotsCompleted,
    this.director,
    this.writer,
    this.links = const [],
  }) : super(id: -1);

  Project.empty()
      : projectType = ProjectType.unknown,
        super(id: -1);

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  int compareTo(Project other) {
    final bool isFavorite = Favorites().isFavorite(getId);
    final bool isOtherFavorite = Favorites().isFavorite(other.getId);

    if (isFavorite && !isOtherFavorite) {
      return -1;
    } else if (!isFavorite && isOtherFavorite) {
      return 1;
    } else if (startDate == null && other.startDate != null) {
      return 1;
    } else if (startDate != null && other.startDate == null) {
      return -1;
    } else {
      return id.compareTo(other.id);
    }
  }
}
