import 'sequence.dart';

enum ProjectType { movie, series }

class Project {
  Project(
      {this.id,
      required this.projectType,
      required this.title,
      required this.description,
      required this.beginDate,
      required this.endDate,
      this.shotsTotal,
      this.shotsCompleted,
      this.director,
      this.writer,
      required this.sequences});

  factory Project.fromJson(json) {
    final ProjectType projectType = (json['isFilm'] as bool) ? ProjectType.movie : ProjectType.series;

    return Project(
      projectType: projectType,
      id: json['Id'].toString(),
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      beginDate: DateTime.parse(json['BeginDate'].toString()),
      endDate: DateTime.parse(json['EndDate'].toString()),
      sequences: <Sequence>[],
    );
  }

  final String? id;
  ProjectType projectType;
  String title;
  String description;
  DateTime beginDate;
  DateTime endDate;
  int? shotsTotal;
  int? shotsCompleted;
  String? director;
  String? writer;
  List<Sequence> sequences;

  ProjectType setProjectType(bool isProject) {
    return isProject ? ProjectType.movie : ProjectType.series;
  }
}
