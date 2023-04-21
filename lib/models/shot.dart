class Shot {
  final String id;
  int number;
  String? value;
  String title;
  String? description;
  bool completed;

  Shot({
    required this.id,
    required this.number,
    this.value,
    required this.title,
    this.description,
    required this.completed,
  });

  factory Shot.fromJson(json) {
    return Shot(
      id: json['Id'].toString(),
      number: json['Number'] as int,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      completed: json['Completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.isEmpty ? null : id,
      'number': number,
      'value': value,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
