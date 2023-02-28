import 'package:flutter/material.dart';

class Member {
  Member(
      {this.id,
      required this.firstName,
      this.lastName,
      this.phone,
      this.image});
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      phone: json['phone'].toString(),
    );
  }

  final String? id;
  String firstName;
  String? lastName;
  String? phone;
  Image? image;
}
