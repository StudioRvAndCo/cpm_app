class Shot {
  Shot({this.id, required this.number, required this.title, this.value, this.description, required this.completed});

  factory Shot.fromJson(json) {
    return Shot(
      id: json['Id'].toString(),
      number: json['Number'] as int,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      completed: json['Completed'] as bool,
    );
  }

  final String? id;
  int number;
  String title;
  String? value;
  String? description;
  bool completed;
}
