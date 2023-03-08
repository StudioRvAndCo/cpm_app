import 'dart:convert';

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
      return <dynamic>[false, null, 408, 'request timed out'];
    }
  }
}
