import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../main.dart';
import '../theme.dart';
import 'api.dart';

class LoginService {
  final API api = API();

  Future<List<dynamic>> login(String username, String password) async {
    return [true, '', 0, ''];

    try {
      final Response response = await post(Uri.parse(api.login),
          headers: <String, String>{'accept': '*/*', 'content-type': 'application/json'},
          body: jsonEncode(<String, String>{'Username': username, 'Password': password}));

      if (response.statusCode == 200) {
        return <dynamic>[true, response.body, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, response.body, response.statusCode, response.reasonPhrase];
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return <dynamic>[false, '', 408, 'request timed out'];
    }
  }

  bool logout() {
    return false;
  }
}

class LoginSnackBar {
  SnackBar generateSnackBar() {
    String message = '';
    switch (loginState.statusCode) {
      case 400:
      case 401:
        message = 'Invalid username or password';
        break;
      case 408:
        message = 'Request timed out';
        break;
      default:
        message = 'Error';
    }

    debugPrint('Code: ${loginState.statusCode}, Reason: ${loginState.reasonPhrase}');

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: CPMThemeLight().theme.colorScheme.error,
      content: Text(message),
    );
  }
}
