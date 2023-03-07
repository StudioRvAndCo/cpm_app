import 'location.dart';
import 'shot.dart';

class Sequence {
  Sequence(
      {this.id,
      required this.number,
      required this.title,
      this.description,
      required this.date,
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
      date: DateTime.parse(json['Date'].toString()),
      shots: shots,
    );
  }

  final String? id;
  int number;
  String title;
  String? description;
  DateTime date;
  Location? location;
  List<Shot> shots;
}
