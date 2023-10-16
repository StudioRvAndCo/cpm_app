import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

Widget deleteBackground() {
  return const ColoredBox(
    color: Colors.red,
    child: Align(alignment: Alignment.centerLeft, child: ListTile(leading: Icon(Icons.delete, color: Colors.white))),
  );
}

Widget editBackground() {
  return const ColoredBox(
    color: Colors.blue,
    child: Align(alignment: Alignment.centerLeft, child: ListTile(trailing: Icon(Icons.edit, color: Colors.white))),
  );
}

Future<bool?> showConfirmationDialog(BuildContext context, String name) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(localizations.dialog_delete_name_confirmation(name)),
        actions: <Widget>[
          TextButton(
            child: Text(localizations.button_cancel),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ElevatedButton(
            autofocus: true,
            child: Text(localizations.button_delete),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
