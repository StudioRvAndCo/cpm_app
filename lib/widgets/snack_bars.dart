import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class CustomSnackBar {
  SnackBar getLoginSnackBar(BuildContext context) {
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

    return SnackBar(
      showCloseIcon: true,
      closeIconColor: Theme.of(context).colorScheme.onError,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SnackBar getModelSnackBar(BuildContext context, bool succeeded, int code, {String message = 'error.no_message'}) {
    if (!succeeded) {
      message = '${'error.error'.tr()} $code - $message';
    }

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: succeeded ? null : Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: succeeded ? null : TextStyle(color: Theme.of(context).colorScheme.onError),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
