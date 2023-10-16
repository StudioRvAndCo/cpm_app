import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDialog extends StatefulWidget {
  const ProjectDialog({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Image? image;
  DateTimeRange dates = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));
  ProjectType type = ProjectType.movie;
  String dateText = '';

  void updateDateText() {
    String res;
    final String firstText = DateFormat.yMd(localizations.localeName).format(dates.start);
    final String lastText = DateFormat.yMd(localizations.localeName).format(dates.end);
    res = '$firstText - $lastText';
    setState(() {
      dateText = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    updateDateText();

    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.all(6.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(localizations.dialog_add_item(localizations.item_project, Gender.male.name)),
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
                    maxLength: 64,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: localizations.dialog_field_title,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
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
                  child: OutlinedButton.icon(
                    onPressed: () => changeDate(),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(dateText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: SegmentedButton<ProjectType>(
                    segments: <ButtonSegment<ProjectType>>[
                      ButtonSegment<ProjectType>(label: Text(localizations.projects_movie), value: ProjectType.movie),
                      ButtonSegment<ProjectType>(label: Text(localizations.projects_series), value: ProjectType.series),
                    ],
                    selected: <ProjectType>{type},
                    onSelectionChanged: (Set<ProjectType> newSelection) {
                      setState(() {
                        type = newSelection.first;
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

  Future<void> changeDate() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(3000),
      initialDateRange: dates,
    );
    if (picked != null) {
      dates = DateTimeRange(start: picked.start, end: picked.end);
      updateDateText();
    }
  }

  void submit() {
    final Project newProject = Project.insert(
      projectType: type,
      title: titleController.text,
      description: descriptionController.text,
      startDate: dates.start,
      endDate: dates.end,
    );
    Navigator.pop(context, newProject);
  }
}
