import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddProjectDialog extends ConsumerStatefulWidget {
  const AddProjectDialog({super.key});

  @override
  ConsumerState<AddProjectDialog> createState() => _AddProjectDialogState();
}

class _AddProjectDialogState extends ConsumerState<AddProjectDialog> {
  ProjectType projectType = ProjectType.movie;
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().weekLater,
  );
  Member? director;
  Member? writer;

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
      if (pickedDateRange == null) {
        return;
      }

      setState(() {
        dateRange = pickedDateRange;
      });
    });
  }

  void _onDirectorSelected(Member? newDirector) {
    if (newDirector == null) {
      return;
    }

    setState(() {
      director = newDirector;
    });
  }

  void _onWriterSelected(Member? newWriter) {
    if (newWriter == null) {
      return;
    }

    setState(() {
      writer = newWriter;
    });
  }

  void _add(BuildContext context) {
    Navigator.pop(
      context,
      Project(
        projectType: projectType,
        title: title.text,
        description: description.text,
        startDate: dateRange.start,
        endDate: dateRange.end,
        director: director,
        writer: writer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_project(1), Gender.male.name),
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
        ...ref.watch(membersProvider).when(
          data: (members) {
            return [
              DropdownButtonFormField<Member>(
                isExpanded: true,
                hint: Text(localizations.dialog_field_director),
                value: director,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: members.map<DropdownMenuItem<Member>>((member) {
                  return DropdownMenuItem<Member>(
                    value: member,
                    child: Text(member.fullName),
                  );
                }).toList(),
                onChanged: _onDirectorSelected,
              ),
              Padding(padding: Paddings.padding8.vertical),
              DropdownButtonFormField<Member>(
                isExpanded: true,
                hint: Text(localizations.dialog_field_writer),
                value: writer,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: members.map<DropdownMenuItem<Member>>((member) {
                  return DropdownMenuItem<Member>(
                    value: member,
                    child: Text(member.fullName),
                  );
                }).toList(),
                onChanged: _onWriterSelected,
              ),
            ];
          },
          loading: () {
            return [CustomPlaceholder.loading()];
          },
          error: (Object error, StackTrace stackTrace) {
            return [CustomPlaceholder.error()];
          },
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
