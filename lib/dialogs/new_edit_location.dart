import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/location.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog(
      {super.key, required this.edit, this.name, this.position});

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
    title = widget.edit
        ? '${'edit.upper'.tr()} ${widget.name!}'
        : '${'new.masc.eau.upper'.tr()} ${'locations.location.lower'.plural(1)}';
    subtitle = widget.edit
        ? '${'edit.upper'.tr()} ${'articles.this.masc.lower'.plural(1)} ${'locations.location.lower'.plural(1)}.'
        : '${'add.upper'.tr()} ${'articles.a.masc.lower'.tr()} ${'new.masc.eau.lower'.tr()} ${'locations.location.lower'.plural(1)}.';
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 330,
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: nameController,
                      builder:
                          (BuildContext context, TextEditingValue value, __) {
                        return TextField(
                          controller: nameController,
                          maxLength: 64,
                          decoration: InputDecoration(
                              labelText: 'attributes.name.upper'.tr(),
                              errorText: nameController.text.trim().isEmpty
                                  ? 'error.empty'.tr()
                                  : null,
                              border: const OutlineInputBorder(),
                              isDense: true),
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
                          isDense: true),
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
                        child: Text('cancel'.tr())),
                    TextButton(onPressed: submit, child: Text('confirm'.tr()))
                  ],
                )
              ]),
        )
      ],
    );
  }

  void submit() {
    if (nameController.text.trim().isEmpty) {
      return;
    }
    final Location newLocation = Location(
        id: '', name: nameController.text, position: positionController.text);
    Navigator.pop(context, newLocation);
  }
}
