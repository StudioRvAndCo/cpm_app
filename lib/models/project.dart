import 'episode.dart';

enum ProjectType { movie, series }

class Project implements Comparable<Project> {
  Project(
      {required this.id,
      required this.projectType,
      required this.title,
      required this.description,
      required this.beginDate,
      required this.endDate,
      this.shotsTotal,
      this.shotsCompleted,
      this.director,
      this.writer,
      required this.episodes});

  factory Project.fromJson(json) {
    final ProjectType projectType = (json['isFilm'] as bool) ? ProjectType.movie : ProjectType.series;

    return Project(
      id: json['Id'].toString(),
      projectType: projectType,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      beginDate: DateTime.parse(json['BeginDate'].toString()),
      endDate: DateTime.parse(json['EndDate'].toString()),
      episodes: <Episode>[],
    );
  }

  double getProgress() {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return 0.0;
    }
    return shotsCompleted! / shotsTotal!;
  }

  bool isMovie() {
    return projectType == ProjectType.movie;
  }

  final String id;
  ProjectType projectType;
  String title;
  String description;
  DateTime beginDate;
  DateTime endDate;
  int? shotsTotal;
  int? shotsCompleted;
  String? director;
  String? writer;
  List<Episode> episodes;
  bool favorite = false;

  @override
  int compareTo(Project other) {
    if (favorite == other.favorite) {
      return beginDate.compareTo(other.beginDate);
    } else if (favorite) {
      return -1;
    } else {
      return 1;
    }
  }
}
