import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/episode.dart';
import 'api.dart';

class EpisodeService {
  final API api = API();

  Future<List<dynamic>> getEpisodes(String projectId) async {
    try {
      final Response response = await get(Uri.parse('${api.episodes}/$projectId'),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final List<dynamic> episodesJson = json.decode(response.body) as List<dynamic>;
      final List<Episode> projects = episodesJson.map((episode) => Episode.fromJson(episode)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, projects, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, null, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, null, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> addEpisode(String projectID, Episode episode) async {
    try {
      final Response response = await post(Uri.parse('${api.episodes}/$projectID'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(episode));

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

  Future<List<dynamic>> deleteEpisode(String projectID, String episodeID) async {
    try {
      final Response response = await delete(Uri.parse('${api.episodes}/$projectID/$episodeID'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          });

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
