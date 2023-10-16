import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class SequenceDialog extends ConsumerStatefulWidget {
  const SequenceDialog({super.key, required this.episode, required this.index});

  final int episode;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SequenceDialogState();
}

class _SequenceDialogState extends ConsumerState<SequenceDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now().hourLater;
  Location? selectedLocation;

  @override
  Widget build(BuildContext context) {
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
                  Text('${'new.fem.upper'} ${'sequences.sequence.lower'}'),
                  Text(
                    '${'add.upper'} ${'articles.a.fem.lower'} ${'new.fem.lower'} ${'sequences.sequence.lower'}.',
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
                    child: TextFormField(
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
                      onPressed: pickDate,
                      icon: const Icon(Icons.calendar_month),
                      label: Text(
                        '${DateFormat.yMd(localizations.localeName).format(date)} | ${startTime.format(context)} - ${endTime.format(context)}',
                      ),
                    ),
                  ),
                ),
                ref.watch(locationsProvider).when(
                  data: (locations) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<Location>(
                        isExpanded: true,
                        hint: Text('attributes.position.upper'),
                        items: locations.map<DropdownMenuItem<Location>>((location) {
                          return DropdownMenuItem<Location>(
                            value: location,
                            child: Text(location.getName),
                          );
                        }).toList(),
                        value: selectedLocation,
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'locations.location.upper',
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    );
                  },
                  loading: () {
                    return requestPlaceholderLoading;
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return requestPlaceholderError;
                  },
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

  Future<void> pickDate() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().hundredYearsBefore,
      lastDate: DateTime.now().hundredYearsLater,
    ).then((newDate) async {
      if (newDate == null) return;

      await showTimePicker(context: context, initialTime: TimeOfDay.now()).then((newStartTime) async {
        if (newStartTime == null) return;

        await showTimePicker(context: context, initialTime: TimeOfDay.now()).then((newEndTime) {
          if (newEndTime == null) return;

          setState(() {
            date = newDate;
            startTime = newStartTime;
            endTime = newEndTime;
          });
        });
      });
    });
  }

  void submit() {
    final Sequence newSequence = Sequence.insert(
      episode: widget.episode,
      index: widget.index,
      title: titleController.text,
      description: descriptionController.text,
      startDate: DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute),
      endDate: DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute),
    );
    Navigator.pop(context, (newSequence, selectedLocation?.id));
  }
}
