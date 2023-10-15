import 'package:cpm/extensions/date_time_helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location/location.dart';
import '../../models/sequence/sequence.dart';
import '../../providers/locations/locations.dart';
import '../../providers/sequences/sequences.dart';
import '../../utils/constants_globals.dart';
import '../icon_label.dart';

class SequenceDetailsPane extends ConsumerStatefulWidget {
  const SequenceDetailsPane({super.key});

  @override
  ConsumerState<SequenceDetailsPane> createState() => _DetailsPaneSequenceState();
}

class _DetailsPaneSequenceState extends ConsumerState<SequenceDetailsPane> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime date;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  Location? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) {
        date = sequence.getDate;
        startTime = sequence.getStartTime;
        endTime = sequence.getEndTime;
        titleController.text = sequence.getTitle;
        descriptionController.text = sequence.description ?? '';
        titleController.selection = TextSelection.collapsed(offset: titleController.text.length);
        descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && titleController.text != sequence.title) {
                    edit(sequence);
                  }
                },
                child: TextField(
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                  controller: titleController,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && descriptionController.text != sequence.description) {
                    edit(sequence);
                  }
                },
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  maxLength: 280,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              ref.watch(locationsProvider).when(
                data: (locations) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<Location>(
                      isExpanded: true,
                      hint: Text('attributes.position.upper'.tr()),
                      items: locations.map<DropdownMenuItem<Location>>((location) {
                        return DropdownMenuItem<Location>(
                          value: location,
                          child: Text(location.getName),
                        );
                      }).toList(),
                      value: sequence.location,
                      onChanged: (location) {
                        setState(() {
                          selectedLocation = location;
                        });
                        edit(sequence);
                      },
                      decoration: InputDecoration(
                        labelText: 'locations.location.upper'.plural(1),
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
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              GestureDetector(
                onTap: () => editDate(sequence),
                behavior: HitTestBehavior.translucent,
                child: IconLabel(
                  text:
                      '${DateFormat.yMd(context.locale.toString()).format(date)} | ${startTime.format(context)} - ${endTime.format(context)}',
                  icon: Icons.event,
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      },
      loading: () {
        return requestPlaceholderLoading;
      },
    );
  }

  Future<void> editDate(Sequence sequence) async {
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
          edit(sequence);
        });
      });
    });
  }

  void edit(Sequence sequence) {
    sequence.title = titleController.text;
    sequence.description = descriptionController.text;
    sequence.startDate = DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute);
    sequence.endDate = DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);
    sequence.location = selectedLocation;

    ref.read(sequencesProvider.notifier).edit(sequence, selectedLocation?.id);
    ref.read(currentSequenceProvider.notifier).set(sequence);
  }
}
