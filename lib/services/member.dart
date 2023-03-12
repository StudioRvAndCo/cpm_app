import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/member.dart';
import 'api.dart';

class MemberService {
  final API api = API();

  Future<List<dynamic>> getMembers() async {
    try {
      final Response response = await get(Uri.parse(api.members),
          headers: <String, String>{
            'accept': 'application/json',
            api.authorization: api.bearer + token
          });

      final List<dynamic> membersJson =
          json.decode(response.body) as List<dynamic>;
      final List<Member> members =
          membersJson.map((member) => Member.fromJson(member)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[
          true,
          members,
          response.statusCode,
          response.reasonPhrase
        ];
      } else {
        debugPrint(response.toString());
        return <dynamic>[
          false,
          <Member>[],
          response.statusCode,
          response.reasonPhrase
        ];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, <Member>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> addMember(Member member) async {
    try {
      final Response response = await post(Uri.parse(api.members),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(member));

      if (response.statusCode == 201) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> editMember(Member member) async {
    try {
      final Response response =
          await put(Uri.parse('${api.members}/${member.id}'),
              headers: <String, String>{
                'accept': '*/*',
                'Content-Type': 'application/json',
                api.authorization: api.bearer + token
              },
              body: jsonEncode(member));

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> deleteMember(Member member) async {
    try {
      final Response response =
          await delete(Uri.parse('${api.members}/${member.id}'),
              headers: <String, String>{
                'accept': '*/*',
                'Content-Type': 'application/json',
                api.authorization: api.bearer + token
              },
              body: jsonEncode(member));

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }
}
