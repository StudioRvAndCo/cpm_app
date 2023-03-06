import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/project.dart';
import 'api.dart';

class ProjectService {
  final API api = API();

  Future<List<dynamic>> getProjects() async {
    try {
      final Response response = await get(Uri.parse(api.projects),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final List<dynamic> membersJson = json.decode(response.body) as List<dynamic>;
      final List<Project> projects = membersJson.map((project) => Project.fromJson(project)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, projects, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Project>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, <Project>[], 408, 'request timed out'];
    }
  }
}
