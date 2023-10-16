import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EpisodeDialog extends StatefulWidget {
  const EpisodeDialog({super.key, required this.project, required this.index});

  final int project;
  final int index;

  @override
  State<StatefulWidget> createState() => _EpisodeDialogState();
}

class _EpisodeDialogState extends State<EpisodeDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTimeRange dates = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 2)));
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
      title: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(6.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('${'new.masc.el.upper'} ${'episodes.episode.lower'}'),
                  Text(
                    '${'add.upper'} ${'articles.a.masc.lower'} ${'new.masc.el.lower'} ${'episodes.episode.lower'}.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
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
                        labelText: 'attributes.title.upper',
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
                        labelText: 'attributes.description.upper',
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
                      child: Text('cancel.upper'),
                    ),
                    TextButton(onPressed: submit, child: Text('confirm.upper')),
                  ],
                ),
              ],
            ),
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
    final Episode newEpisode = Episode.insert(
      project: widget.project,
      index: widget.index,
      title: titleController.text,
      description: descriptionController.text,
    );
    Navigator.pop(context, newEpisode);
  }
}
