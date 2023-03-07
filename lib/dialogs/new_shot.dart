import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewShotDialog extends StatefulWidget {
  const NewShotDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NewShotDialogState();
}

class _NewShotDialogState extends State<NewShotDialog> {
  _NewShotDialogState();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController lineController = TextEditingController();
  final List<String> values = <String>[
    'attributes.values.full'.tr(),
    'attributes.values.medium_full'.tr(),
    'attributes.values.cowboy'.tr(),
    'attributes.values.medium'.tr(),
    'attributes.values.medium_closeup'.tr(),
    'attributes.values.closeup'.tr(),
    'attributes.values.extreme_closeup'.tr(),
    'attributes.values.insert'.tr(),
    'attributes.values.sequence'.tr(),
    'attributes.values.landscape'.tr(),
    'attributes.values.drone'.tr(),
    'attributes.values.other'.tr()
  ];
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
                Text('${'new.masc.eau.upper'.tr()} ${'shots.shot.lower'.plural(1)}'),
                Text(
                  '${'add.upper'.tr()} ${'articles.a.masc.lower'.tr()} ${'new.masc.eau.lower'.tr()} ${'shots.shot.lower'.plural(1)}.',
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
                child: TextField(
                  maxLength: 64,
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: 'attributes.title.upper'.tr(), border: const OutlineInputBorder(), isDense: true),
                  autofocus: true,
                  onEditingComplete: submit,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: TextField(
                  maxLength: 280,
                  maxLines: 4,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: 'attributes.description.upper'.tr(),
                      border: const OutlineInputBorder(),
                      isDense: true),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: TextField(
                  maxLength: 64,
                  controller: lineController,
                  decoration: InputDecoration(
                      labelText: 'attributes.line.upper'.tr(), border: const OutlineInputBorder(), isDense: true),
                  onEditingComplete: submit,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  hint: Text('shots.value.upper'.plural(1)),
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
                      labelText: 'shots.value.upper'.plural(1), border: const OutlineInputBorder(), isDense: true),
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
                    child: Text('cancel.upper'.tr())),
                TextButton(onPressed: submit, child: Text('confirm.upper'.tr()))
              ],
            )
          ]),
        )
      ],
    );
  }

  void submit() {
    Navigator.pop(context);
  }
}
