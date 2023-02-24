import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/project.dart';

class NewEpisodeDialog extends StatefulWidget {
  const NewEpisodeDialog({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NewEpisodeDialogState();
}

class _NewEpisodeDialogState extends State<NewEpisodeDialog> {
  _NewEpisodeDialogState();

  String? title;
  String? description;
  DateTimeRange? dates;
  String dateText = '';

  @override
  void initState() {
    updateDateText();
    return super.initState();
  }

  void updateDateText() {
    String res;
    if (dates != null) {
      final String firstText =
          DateFormat.yMd(Intl.systemLocale).format(dates!.start);
      final String lastText =
          DateFormat.yMd(Intl.systemLocale).format(dates!.end);
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
      title: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Text>[
                Text('New Episode'),
                Text(
                  'Create a new episode',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: SizedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 330,
                        child: TextFormField(
                          maxLength: 64,
                          decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                              isDense: true),
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
                          decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
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
                            final DateTimeRange? picked =
                                await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(3000),
                                    initialDateRange: dates);
                            if (picked != null) {
                              dates = DateTimeRange(
                                  start: picked.start, end: picked.end);
                              updateDateText();
                            }
                          },
                          icon: Icon(Icons.calendar_month),
                          label: Text(dateText),
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
          ),
        )
      ],
    );
  }
}
