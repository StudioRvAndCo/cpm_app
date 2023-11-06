import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

SnackBar getInfoSnackBar(String message) {
  return _getBaseSnackBar(message);
}

SnackBar getErrorSnackBar(String error) {
  return _getBaseSnackBar('${localizations.error_error}: $error');
}

SnackBar _getBaseSnackBar(String data) {
  return SnackBar(
    content: Text(data),
  );
}
