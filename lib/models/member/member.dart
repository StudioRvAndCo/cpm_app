import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'member.g.dart';

@JsonSerializable()
class Member extends BaseModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? photo;

  String get fullName => '$firstName${firstName != null ? ' ' : ''}${lastName?.toUpperCase()}';

  Member({
    required super.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.photo,
  });

  Member.insert({
    this.firstName,
    this.lastName,
    this.phone,
    this.photo,
  }) : super(id: -1);

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
