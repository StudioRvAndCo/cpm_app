import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddEpisodeDialog extends StatefulWidget {
  const AddEpisodeDialog({
    super.key,
    required this.projectId,
    required this.index,
  });

  final int projectId;
  final int index;

  @override
  State<AddEpisodeDialog> createState() => _AddEpisodeDialogState();
}

class _AddEpisodeDialogState extends State<AddEpisodeDialog> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  void _cancel(BuildContext context) {
    context.pop();
  }

  void _add(BuildContext context) {
    context.pop(
      Episode(
        project: widget.projectId,
        index: widget.index,
        title: title.text,
        description: description.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      cancel: () => _cancel(context),
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_episode(1), Gender.male.name),
      action: localizations.button_add,
      fields: [
        TextField(
          controller: title,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_title,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: description,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_description,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
