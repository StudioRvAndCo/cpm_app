import 'package:flutter/foundation.dart';

@immutable
class Event {
  const Event({required this.title, required this.description});

  final String title;
  final String description;

  @override
  bool operator ==(Object other) => other is Event && title == other.title;

  @override
  String toString() => title;

  @override
  int get hashCode => Object.hash(title, description);
}
