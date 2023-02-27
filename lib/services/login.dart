import 'dart:convert';

import 'package:http/http.dart';

import 'api.dart';

class LoginService {
  final API api = API();

  // TODO remove return true
  Future<bool> connect(String username, String password) async {
    return true;

    final Response response = await post(Uri.parse(api.login),
        headers: <String, String>{'accept': '*/*', 'content-type': 'application/json'},
        body: jsonEncode(<String, String>{'Username': username, 'Password': password}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
