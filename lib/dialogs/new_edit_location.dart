import 'package:flutter/material.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog({super.key, required this.edit, this.name, this.position});

  final String? name;
  final String? position;
  final bool edit;

  @override
  State<StatefulWidget> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  late final TextEditingController nameController;
  late final TextEditingController positionController;

  late String title;
  late String subtitle;

  @override
  void initState() {
    title = widget.edit ? 'Edit Location' : 'New Location';
    subtitle = widget.edit ? 'Edit a location.' : 'Create a new location.';
    nameController = TextEditingController(text: widget.name);
    positionController = TextEditingController(text: widget.position);
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.all(6.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(title),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: nameController,
                  builder: (BuildContext context, TextEditingValue value, __) {
                    return TextField(
                      controller: nameController,
                      maxLength: 64,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          errorText: nameController.text.trim().isEmpty ? "Can't be empty." : null,
                          border: const OutlineInputBorder(),
                          isDense: true),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: TextField(
                  controller: positionController,
                  decoration: const InputDecoration(labelText: 'Position', border: OutlineInputBorder(), isDense: true),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (nameController.text.trim().isEmpty) {
                        return;
                      }
                      // TODO(mael): add member via API
                      Navigator.pop(context);
                    },
                    child: const Text('OK'))
              ],
            )
          ]),
        )
      ],
    );
  }
}
