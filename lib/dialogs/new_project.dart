import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../models/project.dart';

class NewProjectDialog extends StatefulWidget {
  const NewProjectDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog> {
  _NewProjectDialogState();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Image? image;
  DateTimeRange? dates;
  ProjectType type = ProjectType.movie;
  String dateText = '';

  @override
  void initState() {
    return super.initState();
  }

  void updateDateText() {
    String res;
    if (dates != null) {
      final String firstText = DateFormat.yMd(context.locale.toString()).format(dates!.start);
      final String lastText = DateFormat.yMd(context.locale.toString()).format(dates!.end);
      res = '$firstText - $lastText';
    } else {
      res = 'dates_dialog'.tr();
    }
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
                )
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              icon: Builder(builder: (BuildContext context) {
                if (image != null) {
                  return SizedBox(height: 80, width: 80, child: image);
                } else {
                  return const Icon(Icons.add_a_photo_outlined, size: 80);
                }
              }),
              onPressed: () async {
                final FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image, lockParentWindow: true);
                if (result != null) {
                  Image imgRes;
                  if (kIsWeb) {
                    imgRes = Image.memory(result.files.single.bytes!);
                  } else {
                    imgRes = Image.file(File(result.files.single.path!));
                  }
                  setState(() {
                    image = imgRes;
                  });
                }
              },
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
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final DateTimeRange? picked = await showDateRangePicker(
                        context: context, firstDate: DateTime(1970), lastDate: DateTime(3000), initialDateRange: dates);
                    if (picked != null) {
                      dates = DateTimeRange(start: picked.start, end: picked.end);
                      updateDateText();
                    }
                  },
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
                    ButtonSegment<ProjectType>(label: Text('projects.series.upper'.tr()), value: ProjectType.series)
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
