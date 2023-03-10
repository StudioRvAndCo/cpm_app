import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LoginSnackBar {
  SnackBar getSnackBar(BuildContext context) {
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
      ),
    );
  }
}

class PopupSnackBar {
  SnackBar getNewProjectSnackBar(BuildContext context, bool succeeded) {
    if (succeeded) {
      return SnackBar(behavior: SnackBarBehavior.floating, content: Text('snack_bars.project.added'.tr()));
    } else {
      return SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
        content:
            Text('snack_bars.project.not_added'.tr(), style: TextStyle(color: Theme.of(context).colorScheme.onError)),
      );
    }
  }
}
