import 'package:flutter/material.dart';

SnackBar getInfoSnackBar(String message) {
  return _getBaseSnackBar(message);
}

SnackBar getErrorSnackBar(String error) {
  return _getBaseSnackBar('Error: $error');
}

SnackBar _getBaseSnackBar(String data) {
  return SnackBar(
    content: Text(data),
    behavior: SnackBarBehavior.floating,
  );
}
