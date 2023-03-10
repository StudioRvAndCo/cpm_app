class Location {
  Location({required this.id, required this.name, this.position});

  factory Location.fromJson(json) {
    return Location(
      id: json['Id'].toString(),
      name: json['Name'].toString(),
      position: json['Position'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
    };
  }

  final String id;
  String name;
  String? position;
}
