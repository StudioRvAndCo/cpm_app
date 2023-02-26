import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/project.dart';

class NewProjectDialog extends StatefulWidget {
  const NewProjectDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog> {
  _NewProjectDialogState();

  String? title;
  Image? image;
  String? description;
  DateTimeRange? dates;
  ProjectType type = ProjectType.movie;
  String dateText = '';

  @override
  void initState() {
    updateDateText();
    return super.initState();
  }

  void updateDateText() {
    String res;
    if (dates != null) {
      final String firstText = DateFormat.yMd(Intl.systemLocale).format(dates!.start);
      final String lastText = DateFormat.yMd(Intl.systemLocale).format(dates!.end);
      res = '$firstText - $lastText';
    } else {
      res = 'Enter production dates';
    }
    setState(() {
      dateText = res;
    });
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
              children: const <Text>[
                Text('New Project'),
                Text(
                  'Create a new project.',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              icon: Builder(builder: (BuildContext context) {
                if (image != null) {
                  return SizedBox(height: 80, width: 80, child: image!);
                } else {
                  return const Icon(Icons.add_a_photo_outlined, size: 80);
                }
              }),
              onPressed: () async {
                final FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image, lockParentWindow: true);
                if (result != null) {
                  final File file = File(result.files.single.path!);
                  setState(() {
                    image = Image.file(file);
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
          child: Form(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    maxLength: 64,
                    decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder(), isDense: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    maxLength: 280,
                    maxLines: 4,
                    decoration:
                        const InputDecoration(labelText: 'Description', border: OutlineInputBorder(), isDense: true),
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
                          context: context,
                          firstDate: DateTime(1970),
                          lastDate: DateTime(3000),
                          initialDateRange: dates);
                      if (picked != null) {
                        dates = DateTimeRange(start: picked.start, end: picked.end);
                        updateDateText();
                      }
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text(dateText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: SegmentedButton(
                    segments: [
                      const ButtonSegment(label: Text('Movie'), value: ProjectType.movie),
                      ButtonSegment(label: Text('Series'), value: ProjectType.series)
                    ],
                    selected: {type},
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
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}
