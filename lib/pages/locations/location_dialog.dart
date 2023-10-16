import 'package:cpm/models/location/location.dart';
import 'package:flutter/material.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog({super.key, this.location});

  final Location? location;

  @override
  State<StatefulWidget> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  late final bool edit;

  late final String title;

  late final TextEditingController nameController;
  late final TextEditingController positionController;

  @override
  void initState() {
    super.initState();

    edit = widget.location != null;

    title = edit ? 'edit.upper' : 'new.masc.eau.upper';

    nameController = TextEditingController(text: widget.location?.name);
    positionController = TextEditingController(text: widget.location?.position);
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
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                          labelText: 'attributes.name.upper',
                          errorText: nameController.text.trim().isEmpty ? 'error.empty' : null,
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        autofocus: true,
                        onEditingComplete: submit,
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
                    decoration: InputDecoration(
                      labelText: 'attributes.position.upper',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    onEditingComplete: submit,
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
                    child: Text('cancel'),
                  ),
                  TextButton(onPressed: submit, child: Text('confirm')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submit() {
    final Location location = edit
        ? Location(
            id: widget.location!.id,
            name: nameController.text,
            position: positionController.text,
          )
        : Location.insert(
            name: nameController.text,
            position: positionController.text,
          );

    Navigator.pop(context, location);
  }
}
