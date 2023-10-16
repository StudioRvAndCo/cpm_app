import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class ShotDialog extends StatefulWidget {
  const ShotDialog({super.key, required this.sequence, required this.index});

  final int sequence;
  final int index;

  @override
  State<StatefulWidget> createState() => _ShotDialogState();
}

class _ShotDialogState extends State<ShotDialog> {
  TextEditingController descriptionController = TextEditingController();
  final List<String> values = ShotValue.labels();
  String? selectedValue;

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
                Text(localizations.dialog_add_item(localizations.item_shot, Gender.male.name)),
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
                  child: TextField(
                    maxLength: 280,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: localizations.dialog_field_description,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text(localizations.dialog_field_value),
                    items: values.map<DropdownMenuItem<String>>((String value) {
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
                    decoration: InputDecoration(
                      labelText: localizations.dialog_field_value,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
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
                    child: Text(localizations.button_cancel),
                  ),
                  TextButton(onPressed: submit, child: Text(localizations.button_add)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submit() {
    final Shot newShot = Shot.insert(
      sequence: widget.sequence,
      index: widget.index,
      value: ShotValue.fromString(selectedValue),
      description: descriptionController.text,
    );
    Navigator.pop(context, newShot);
  }
}
