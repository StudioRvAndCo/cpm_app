import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/common/widgets/colored_circle.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddShotDialog extends StatefulWidget {
  const AddShotDialog({
    super.key,
    required this.sequenceId,
    required this.index,
  });

  final int sequenceId;
  final int index;

  @override
  State<AddShotDialog> createState() => _AddShotDialogState();
}

class _AddShotDialogState extends State<AddShotDialog> {
  final TextEditingController description = TextEditingController();
  ShotValue value = ShotValue.other;

  void _onValueSelected(ShotValue? newValue) {
    if (newValue == null) return;

    setState(() {
      value = newValue;
    });
  }

  void _cancel(BuildContext context) {
    context.pop();
  }

  void _add(BuildContext context) {
    context.pop(
      Shot(
        sequence: widget.sequenceId,
        index: widget.index,
        value: value,
        description: description.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      cancel: () => _cancel(context),
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_shot(1), Gender.male.name),
      action: localizations.button_add,
      fields: [
        TextField(
          controller: description,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_description,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        DropdownButtonFormField<ShotValue>(
          isExpanded: true,
          hint: Text(localizations.dialog_field_value),
          value: value,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_value,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
          items: ShotValue.values.map<DropdownMenuItem<ShotValue>>((value) {
            return DropdownMenuItem<ShotValue>(
              value: value,
              child: Row(
                children: [
                  ColoredCircle(color: value.color),
                  Padding(padding: Paddings.padding4.horizontal),
                  Text(value.label),
                ],
              ),
            );
          }).toList(),
          onChanged: _onValueSelected,
        ),
      ],
    );
  }
}
