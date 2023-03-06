import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../main.dart';
import 'api.dart';

class LoginService {
  final API api = API();

  Future<List<dynamic>> login(String username, String password) async {
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
  SnackBar generateSnackBar(BuildContext context) {
    String message = '';
    switch (loginState.statusCode) {
      case 400:
      case 401:
        message = 'error.username-password'.tr();
        break;
      case 408:
        message = 'error.timeout'.tr();
        break;
      default:
        message = 'error.error'.tr();
    }

    debugPrint('Code: ${loginState.statusCode}, Reason: ${loginState.reasonPhrase}');

    return SnackBar(
      showCloseIcon: true,
      closeIconColor: Theme.of(context).colorScheme.onError,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
