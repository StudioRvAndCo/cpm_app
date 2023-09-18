import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSnackBars {
  SnackBar getLoginSnackBar() {
    return const SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text('Login failed.'),
    );
  }

  SnackBar getModelSnackBar(BuildContext context, bool succeeded, {String message = 'error.no_message'}) {
    if (!succeeded) {
      message = '${'error.error'.tr()} - $message';
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
