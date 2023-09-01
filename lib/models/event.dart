import 'package:flutter/foundation.dart';

@immutable
class Event {
  final String title;
  final String description;

  @override
  int get hashCode => Object.hash(title, description);

  const Event({required this.title, required this.description});

  @override
  bool operator ==(Object other) => other is Event && title == other.title;

  @override
  String toString() => title;
}
