class Member {
  const Member({required this.firstName, required this.lastName, required this.phone});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      firstName: json['firstName'].toString(),
      lastName: json['lastName'].toString(),
      phone: json['phone'].toString(),
    );
  }

  final String firstName;
  final String lastName;
  final String phone;
}
