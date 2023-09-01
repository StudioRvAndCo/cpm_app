import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/location/location.dart';

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

    title = edit ? 'edit.upper'.tr() : 'new.masc.eau.upper'.tr();

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
                        labelText: 'attributes.name.upper'.tr(),
                        errorText: nameController.text.trim().isEmpty ? 'error.empty'.tr() : null,
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
                    labelText: 'attributes.position.upper'.tr(),
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
                  child: Text('cancel'.tr()),
                ),
                TextButton(onPressed: submit, child: Text('confirm'.tr())),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  void submit() {
    Location location = edit
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
