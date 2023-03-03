import 'sequence.dart';

enum ProjectType { movie, series }

class Project {
  Project(
      {this.id,
      required this.projectType,
      required this.title,
      this.description,
      required this.beginDate,
      required this.endDate,
      this.shotsTotal,
      this.shotsCompleted,
      this.director,
      this.writer,
      required this.sequences});

  final String? id;
  ProjectType projectType;
  String title;
  String? description;
  DateTime beginDate;
  DateTime endDate;
  int? shotsTotal;
  int? shotsCompleted;
  String? director;
  String? writer;
  List<Sequence> sequences;
}
