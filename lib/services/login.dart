import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'api.dart';

class LoginService {
  final API api = API();

  Future<bool> login(String username, String password) async {
    final Response response = await post(Uri.parse(api.login),
        headers: <String, String>{'accept': '*/*', 'content-type': 'application/json'},
        body: jsonEncode(<String, String>{'Username': username, 'Password': password}));

    if (response.statusCode == 200) {
      return true;
    } else {
      debugPrint(response.toString());
      return false;
    }
  }

  bool logout() {
    return false;
  }
}
