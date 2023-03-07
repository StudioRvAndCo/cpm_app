class Location {
  Location({required this.id, required this.name, this.position});

  factory Location.fromJson(json) {
    return Location(
      id: json['Id'].toString(),
      name: json['Name'].toString(),
      position: json['Link'].toString(), // TODO(mael): change to 'Position' in backend
    );
  }

  final String id;
  String name;
  String? position;
}
