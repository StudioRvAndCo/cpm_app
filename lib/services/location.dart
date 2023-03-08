import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/location.dart';
import 'api.dart';

class LocationService {
  final API api = API();

  Future<List<dynamic>> getLocations() async {
    try {
      final Response response = await get(Uri.parse(api.locations),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      final List<dynamic> membersJson = json.decode(response.body) as List<dynamic>;
      final List<Location> locations = membersJson.map((location) => Location.fromJson(location)).toList();

      if (response.statusCode == 200) {
        return <dynamic>[true, locations, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Location>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, <Location>[], 408, 'error.timeout'.tr()];
    }
  }
}
