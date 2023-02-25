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
  final List<String> values = [
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
  String? selectedValue;
  String? line;

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
                  'Create a new shot.',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 330,
                      child: TextFormField(
                        maxLength: 64,
                        decoration: const InputDecoration(
                            labelText: 'Line',
                            border: OutlineInputBorder(),
                            isDense: true),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 330,
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text('Value'),
                        items: values
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
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
        )
      ],
    );
  }
}
