import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.action,
  });

  final String action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('confirm_dialog'),
      actions: <Widget>[
        TextButton(
          child: Text('cancel'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        ElevatedButton(
          child: Text('confirm'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }
}

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

Future<bool?> showConfirmationDialog(BuildContext context, String action) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('confirm_dialog'),
        actions: <Widget>[
          TextButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          ElevatedButton(
            autofocus: true,
            child: Text('confirm'),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}
