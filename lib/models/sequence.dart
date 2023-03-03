import 'location.dart';

class Sequence {
  Sequence(
      {this.id,
      this.number,
      required this.title,
      this.description,
      required this.date,
      required this.startTime,
      required this.endTime,
      this.location});

  final String? id;
  int? number;
  String title;
  String? description;
  DateTime date;
  DateTime startTime;
  DateTime endTime;
  Location? location;
}
