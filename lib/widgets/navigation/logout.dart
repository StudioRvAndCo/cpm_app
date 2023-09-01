import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Logout {
  Future<bool> confirm(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('authentication.logout.upper'.tr()),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('authentication.logout_confirmation'.tr()),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(
                    'cancel'.tr(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'authentication.logout.upper'.tr(),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
