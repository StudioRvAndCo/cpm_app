import 'package:flutter/material.dart';

class Member {
  Member(
      {this.id,
      required this.firstName,
      this.lastName,
      this.telephone,
      this.image});

  final String? id;
  String firstName;
  String? lastName;
  String? telephone;
  Image? image;
}
