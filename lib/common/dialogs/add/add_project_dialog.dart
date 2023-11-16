import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProjectDialog extends StatefulWidget {
  const AddProjectDialog({super.key});

  @override
  State<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends State<AddProjectDialog> {
  ProjectType projectType = ProjectType.movie;
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().weekLater,
  );

  void _onProjectTypeChanged(Set<ProjectType> type) {
    setState(() {
      projectType = type.first;
    });
  }

  Future<void> _pickDateRange() async {
    await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.now().hundredYearsBefore,
      lastDate: DateTime.now().hundredYearsLater,
    ).then((pickedDateRange) {
      if (pickedDateRange == null) return;

      setState(() {
        dateRange = pickedDateRange;
      });
    });
  }

  void _cancel(BuildContext context) {
    context.pop();
  }

  void _add(BuildContext context) {
    context.pop(
      Project(
        projectType: projectType,
        title: title.text,
        description: description.text,
        startDate: dateRange.start,
        endDate: dateRange.end,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      cancel: () => _cancel(context),
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_project, Gender.male.name),
      action: localizations.button_add,
      fields: [
        Row(
          children: [
            Expanded(
              child: SegmentedButton<ProjectType>(
                segments: ProjectType.values.where((type) {
                  return type != ProjectType.unknown;
                }).map((type) {
                  return ButtonSegment(
                    value: type,
                    label: Text(type.label),
                  );
                }).toList(),
                selected: {projectType},
                onSelectionChanged: _onProjectTypeChanged,
              ),
            ),
          ],
        ),
        Padding(padding: Paddings.padding8.vertical),
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
        Padding(padding: Paddings.padding8.vertical),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text('${dateRange.start.yMd} - ${dateRange.end.yMd}'),
                onPressed: _pickDateRange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
