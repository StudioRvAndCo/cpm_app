import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/project.dart';

class NewProjectDialog extends StatefulWidget {
  const NewProjectDialog({super.key});

  @override
  State<StatefulWidget> createState() => _NewProjectDialogState();
}

class _NewProjectDialogState extends State<NewProjectDialog>
    with AutomaticKeepAliveClientMixin<NewProjectDialog> {
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
    super.initState();
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
    String dateDisplayed = 'Enter production dates';
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Text>[
              Text('New Project'),
              Text(
                'Create a new project',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined, size: 40),
            onPressed: () {},
          ),
        ],
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
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
                      width: 300,
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
                      width: 300,
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
                        label: Text(dateDisplayed),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      child: SegmentedButton(
                        segments: [
                          ButtonSegment(
                              label: Text('Movie'), value: ProjectType.movie),
                          ButtonSegment(
                              label: Text('Series'), value: ProjectType.series)
                        ],
                        selected: {type},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            type = newSelection.first;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {}, child: Text('Cancel')),
                      TextButton(onPressed: () {}, child: Text('OK'))
                    ],
                  )
                ]),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
