import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../models/project/project.dart';
import '../../models/project/project_type.dart';

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
    final String firstText = DateFormat.yMd(context.locale.toString()).format(dates.start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(dates.end);
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
                Text('${'new.masc.eau.upper'.tr()} ${'projects.project.lower'.plural(1)}'),
                Text(
                  '${'add.upper'.tr()} ${'articles.a.masc.lower'.tr()} ${'new.masc.eau.lower'.tr()} ${'projects.project.lower'.plural(1)}.',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              icon: Builder(builder: (BuildContext context) {
                return image != null
                    ? SizedBox(height: 80, width: 80, child: image)
                    : const Icon(Icons.add_a_photo, size: 80);
              }),
              onPressed: () => changePhoto(),
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
                    labelText: 'attributes.title.upper'.tr(),
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
                    labelText: 'attributes.description.upper'.tr(),
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
                    ButtonSegment<ProjectType>(label: Text('projects.movie.upper'.tr()), value: ProjectType.movie),
                    ButtonSegment<ProjectType>(label: Text('projects.series.upper'.tr()), value: ProjectType.series),
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
                  child: Text('cancel.upper'.tr()),
                ),
                TextButton(onPressed: submit, child: Text('confirm.upper'.tr())),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  Future<void> changePhoto() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      lockParentWindow: true,
      withData: kIsWeb,
    );
    if (result != null) {
      PlatformFile file = result.files.single;
      setState(() {
        image = kIsWeb ? Image.memory(file.bytes!) : Image.file(File(file.path!));
      });
    }
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
