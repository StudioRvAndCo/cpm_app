import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/member.dart';
import 'api.dart';

class MemberService {
  final API api = API();

  Future<List<dynamic>> getMembers() async {
    try {
      final Response response = await get(Uri.parse(api.members),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final List<dynamic> membersJson = json.decode(response.body) as List<dynamic>;
      final List<Member> members = membersJson.map((member) => Member.fromJson(member)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, members, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Member>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, <Member>[], 408, 'request timed out'];
    }
  }
}
