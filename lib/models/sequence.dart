import 'location.dart';
import 'shot.dart';

class Sequence {
  Sequence(
      {required this.id,
      required this.number,
      required this.title,
      this.description,
      required this.startDate,
      required this.endDate,
      this.location,
      required this.shots});

  factory Sequence.fromJson(json) {
    final shotsJson = json['Shots'];
    final List<Shot> shots = shotsJson.map<Shot>((shot) => Shot.fromJson(shot)).toList() as List<Shot>;

    return Sequence(
      id: json['Id'].toString(),
      number: json['Number'] as int,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      startDate: DateTime.parse(json['BeginDate'].toString()),
      endDate: DateTime.parse(json['EndDate'].toString()),
      shots: shots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.isEmpty ? null : id,
      'number': number,
      'title': title,
      'description': description,
      'beginDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'shots': shots,
    };
  }

  final String id;
  int number;
  String title;
  String? description;
  DateTime startDate;
  DateTime endDate;
  Location? location;
  List<Shot> shots;
}
