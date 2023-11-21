// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true)
class Project extends BaseModel implements Comparable<Project> {
  ProjectType projectType;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  @JsonKey(toJson: idToJson)
  Member? director;
  @JsonKey(toJson: idToJson)
  Member? writer;
  @JsonKey(includeToJson: false)
  int? shotsTotal;
  @JsonKey(includeToJson: false)
  int? shotsCompleted;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<Link> links;

  Project({
    super.id,
    this.projectType = ProjectType.unknown,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.director,
    this.writer,
    this.shotsTotal,
    this.shotsCompleted,
    this.links = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

  bool get isMovie => projectType == ProjectType.movie;

  String get getTitle {
    return title == null || title!.isEmpty ? localizations.projects_no_title : title!;
  }

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  DateTime get getStartDate => startDate ?? DateTime.now();

  DateTime get getEndDate => endDate ?? DateTime.now().weekLater;

  String get dateText {
    if (startDate == null || endDate == null) return localizations.projects_no_dates;

    return '${startDate?.yMd} - ${endDate?.yMd}';
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
    links.sort(
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

  @override
  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(
      _$ProjectToJson(this)
        ..addAll({
          'director': director?.toJsonCache(),
          'writer': writer?.toJsonCache(),
          'shots_total': shotsTotal,
          'shots_completed': shotsCompleted,
        }),
    );
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
      return super.compareIds(other.id);
    }
  }
}
