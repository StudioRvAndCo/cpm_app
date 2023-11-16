// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member extends BaseModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;

  Member({
    super.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  String get fullName {
    return '$firstName${firstName != null ? ' ' : ''}${lastName?.toUpperCase()}';
  }

  String get phoneAndEmail {
    if (phone != null && phone!.isNotEmpty && email != null && email!.isNotEmpty) {
      return '$phone • $email';
    } else if (email == null || email!.isEmpty) {
      return phone!;
    } else if (phone == null || phone!.isEmpty) {
      return email!;
    } else {
      return '';
    }
  }

  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(_$MemberToJson(this));
  }
}
