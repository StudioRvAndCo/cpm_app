import 'package:flutter/material.dart';

class Member {
  Member({required this.id, required this.firstName, this.lastName, this.phoneNumber, this.image});

  factory Member.fromJson(json) {
    return Member(
      id: json['Id'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      phoneNumber: json['PhoneNumber'].toString(),
    );
  }

  final String id;
  String firstName;
  String? lastName;
  String? phoneNumber;
  Image? image;
}
