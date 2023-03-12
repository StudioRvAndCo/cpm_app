import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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

      final List<dynamic> projectsJson = json.decode(response.body) as List<dynamic>;
      final List<Project> projects = projectsJson.map((project) => Project.fromJson(project)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, projects, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Project>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, <Project>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> getProject(String id) async {
    try {
      final Response response = await get(Uri.parse('${api.projects}/$id'),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final dynamic projectJson = json.decode(response.body);
      final Project project = Project.fromJsonComplete(projectJson);

      if (response.statusCode == 200) {
        return <dynamic>[true, project, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, null, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, null, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> addProject(Project project) async {
    try {
      final Response response = await post(Uri.parse(api.projects),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(project));

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

  Future<List<dynamic>> editProject(Project project) async {
    try {
      final Response response = await put(Uri.parse('${api.projects}/${project.id}'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(project));

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
