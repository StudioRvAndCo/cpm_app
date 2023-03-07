import 'episode.dart';
import 'sequence.dart';

enum ProjectType { movie, series }

class Project {
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
      this.episodes,
      required this.sequences});

  factory Project.fromJson(json) {
    final ProjectType projectType = (json['isFilm'] as bool) ? ProjectType.movie : ProjectType.series;

    // TODO(mael): remove null checks by returning empty lists from the backend
    List<Sequence> sequences = <Sequence>[];
    final sequencesJson = json['Sequences'];
    if (projectType == ProjectType.movie && sequencesJson != null) {
      sequences = sequencesJson.map<Sequence>((sequence) => Sequence.fromJson(sequence)).toList() as List<Sequence>;
    }

    return Project(
      id: json['Id'].toString(),
      projectType: projectType,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      beginDate: DateTime.parse(json['BeginDate'].toString()),
      endDate: DateTime.parse(json['EndDate'].toString()),
      sequences: sequences,
    );
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
  List<Episode>? episodes;
  List<Sequence> sequences;
}
