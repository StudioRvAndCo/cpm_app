import 'package:flutter/material.dart';

class NewShotDialog extends StatefulWidget {
  const NewShotDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NewShotDialogState();
}

class _NewShotDialogState extends State<NewShotDialog> {
  _NewShotDialogState();

  String? title;
  String? description;
  final List<String> valuesList = [
    'Full shot',
    'Medium full shot',
    'Cowboy shot',
    'Medium shot',
    'Medium closeup shot',
    'Closeup shot',
    'Extreme closeup shot',
    'Insert',
    'Sequence',
    'Landscape'
  ];
  String? value;
  String? line;

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Text>[
                Text('New Shot'),
                Text(
                  'Create a new shot',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: SizedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 330,
                        child: TextFormField(
                          maxLength: 64,
                          decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                              isDense: true),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 330,
                        child: TextFormField(
                          maxLength: 280,
                          maxLines: 4,
                          decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                              isDense: true),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu(
                          width: 330,
                          label: Text('Value'),
                          dropdownMenuEntries: valuesList
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                              value: value,
                              label: value,
                            );
                          }).toList()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'))
                      ],
                    )
                  ]),
            ),
          ),
        )
      ],
    );
  }
}
