import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar getInfoSnackBar(String message) {
    return _getBaseSnackBar(message);
  }

  static SnackBar getErrorSnackBar(String error) {
    return _getBaseSnackBar('Error: $error');
  }

  static SnackBar _getBaseSnackBar(String data) {
    return SnackBar(
      content: Text(data),
      behavior: SnackBarBehavior.floating,
    );
  }
}
