import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/episode.dart';
import '../models/location.dart';
import '../models/member.dart';
import '../models/project.dart';

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
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class PopupSnackBar {
  SnackBar getNewModelSnackBar(
      BuildContext context, bool succeeded, int code, Object model) {
    String message = 'error.no_message';

    switch (model.runtimeType) {
      case Project:
        if (succeeded) {
          message = 'snack_bars.project.added'.tr();
        } else {
          message = 'snack_bars.project.not_added'.tr();
        }
        break;
      case Episode:
        if (succeeded) {
          message = 'snack_bars.episode.added'.tr();
        } else {
          message = 'snack_bars.episode.not_added'.tr();
        }
        break;
      case Location:
        if (succeeded) {
          message = 'snack_bars.location.added'.tr();
        } else {
          message = 'snack_bars.location.not_added'.tr();
        }
        break;
      case Member:
        if (succeeded) {
          message = 'snack_bars.member.added'.tr();
        } else {
          message = 'snack_bars.member.not_added'.tr();
        }
        break;
    }

    if (!succeeded) {
      message = '${'error.error'.tr()} $code - $message';
    }

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: succeeded ? null : Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: succeeded
            ? null
            : TextStyle(color: Theme.of(context).colorScheme.onError),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SnackBar getEditedModelSnackBar(
      BuildContext context, bool succeeded, int code, Object model) {
    String message = 'error.no_message';

    switch (model.runtimeType) {
      case Project:
        if (succeeded) {
          message = 'snack_bars.project.edited'.tr();
        } else {
          message = 'snack_bars.project.not_edited'.tr();
        }
        break;
      case Episode:
        if (succeeded) {
          message = 'snack_bars.episode.edited'.tr();
        } else {
          message = 'snack_bars.episode.not_edited'.tr();
        }
        break;
      case Location:
        if (succeeded) {
          message = 'snack_bars.location.edited'.tr();
        } else {
          message = 'snack_bars.location.not_edited'.tr();
        }
        break;
      case Member:
        if (succeeded) {
          message = 'snack_bars.member.edited'.tr();
        } else {
          message = 'snack_bars.member.not_edited'.tr();
        }
        break;
    }

    if (!succeeded) {
      message = '${'error.error'.tr()} $code - $message';
    }

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: succeeded ? null : Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: succeeded
            ? null
            : TextStyle(color: Theme.of(context).colorScheme.onError),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  SnackBar getDeletedModelSnackBar(
      BuildContext context, bool succeeded, int code, Object model) {
    String message = 'error.no_message';

    switch (model.runtimeType) {
      case Project:
        if (succeeded) {
          message = 'snack_bars.project.deleted'.tr();
        } else {
          message = 'snack_bars.project.not_deleted'.tr();
        }
        break;
      case Episode:
        if (succeeded) {
          message = 'snack_bars.episode.deleted'.tr();
        } else {
          message = 'snack_bars.episode.not_deleted'.tr();
        }
        break;
      case Location:
        if (succeeded) {
          message = 'snack_bars.location.deleted'.tr();
        } else {
          message = 'snack_bars.location.not_deleted'.tr();
        }
        break;
      case Member:
        if (succeeded) {
          message = 'snack_bars.member.deleted'.tr();
        } else {
          message = 'snack_bars.member.not_deleted'.tr();
        }
        break;
    }

    if (!succeeded) {
      message = '${'error.error'.tr()} $code - $message';
    }

    return SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      backgroundColor: succeeded ? null : Theme.of(context).colorScheme.error,
      content: Text(
        message,
        style: succeeded
            ? null
            : TextStyle(color: Theme.of(context).colorScheme.onError),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
