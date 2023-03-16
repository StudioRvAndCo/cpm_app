import 'package:flutter/material.dart';

class Member {
  Member({required this.id, required this.firstName, this.lastName, this.phone, this.image});

  factory Member.fromJson(json) {
    return Member(
      id: json['Id'].toString(),
      firstName: json['FirstName'].toString(),
      lastName: json['LastName'].toString(),
      phone: json['Phone'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'phone': phone,
    };
  }

  final String id;
  String firstName;
  String? lastName;
  String? phone;
  Image? image;
}
