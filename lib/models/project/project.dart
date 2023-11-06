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

  @JsonKey(includeToJson: false)
  int? shotsTotal;
  @JsonKey(includeToJson: false)
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

  String get progressText {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return '';
    }

    return '$shotsCompleted/$shotsTotal';
  }

  void sortLinks() {
    links?.sort(
      (Link a, Link b) {
        if (a.index == null && b.index == null) {
          return 0;
        } else if (a.index == null) {
          return -1;
        } else if (b.index == null) {
          return 1;
        }

        return a.index!.compareTo(b.index!);
      },
    );
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
  Map<String, dynamic> toJsonCache() {
    return _$ProjectToJson(this)
      ..addAll({
        'id': id,
        'shots_total': shotsTotal,
        'shots_completed': shotsCompleted,
      });
  }

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
