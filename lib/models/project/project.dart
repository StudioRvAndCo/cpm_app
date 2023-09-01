import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'link.dart';
import 'project_type.dart';

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool favorite = false;

  String get getTitle => title ?? 'Untitled';

  String get getDescription => description ?? '';

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

  void toggleFavorite() {
    favorite = !favorite;
  }

  @override
  int compareTo(Project other) {
    if (startDate == null) {
      return -1;
    } else if (other.startDate == null) {
      return 1;
    } else if (favorite == other.favorite) {
      return other.startDate!.compareTo(startDate!);
    } else if (favorite) {
      return -1;
    } else {
      return 1;
    }
  }
}
