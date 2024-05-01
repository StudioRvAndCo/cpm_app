import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SequenceDetailsTab extends ConsumerStatefulWidget {
  const SequenceDetailsTab({super.key});

  @override
  ConsumerState<SequenceDetailsTab> createState() => _ProjectDetailsTabState();
}

class _ProjectDetailsTabState extends ConsumerState<SequenceDetailsTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTime? date = DateTime.now();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now().hourLater;
  Location? location;

  @override
  void initState() {
    super.initState();

    final sequence = ref.read(currentSequenceProvider).value;
    title.text = sequence?.title ?? '';
    description.text = sequence?.description ?? '';
    date = sequence?.getDate;
    startTime = sequence?.getStartTime;
    endTime = sequence?.getEndTime;
    location = sequence?.location;
  }

  Future<void> _pickDateTime(Sequence sequence) async {
    final project = ref.read(currentProjectProvider).value;

    await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: project?.startDate ?? DateTime.now().hundredYearsBefore,
      lastDate: project?.endDate ?? DateTime.now().hundredYearsLater,
    ).then((pickedDate) async {
      if (pickedDate == null) {
        return;
      }

      await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: localizations.dialog_field_start_time,
      ).then((pickedStartTime) async {
        if (pickedStartTime == null) {
          return;
        }

        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          helpText: localizations.dialog_field_end_time,
        ).then((pickedEndTime) {
          if (pickedEndTime == null) {
            return;
          }

          date = pickedDate;
          startTime = pickedStartTime;
          endTime = pickedEndTime;
          _edit(sequence);
        });
      });
    });
  }

  void _onLocationSelected(Sequence sequence, Location? newLocation) {
    if (newLocation == null) {
      return;
    }

    location = newLocation;
    _edit(sequence);
  }

  void _onSubmitted(Sequence sequence) {
    if (title.text == sequence.title &&
        description.text == sequence.description &&
        location == sequence.location &&
        date == sequence.getDate &&
        startTime == sequence.getStartTime &&
        endTime == sequence.getEndTime) {
      return;
    }

    _edit(sequence);
  }

  void _edit(Sequence sequence) {
    sequence.title = title.text;
    sequence.description = description.text;
    if (date != null && startTime != null) {
      sequence.startDate = DateTime(date!.year, date!.month, date!.day, startTime!.hour, startTime!.minute);
    }
    if (date != null && endTime != null) {
      sequence.endDate = DateTime(date!.year, date!.month, date!.day, endTime!.hour, endTime!.minute);
    }
    sequence.location = location;

    ref.read(sequencesProvider.notifier).edit(sequence);
    ref.read(currentSequenceProvider.notifier).set(sequence);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(
      data: (sequence) {
        return Column(
          children: [
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_month),
                  label: Text(sequence.dateText),
                  onPressed: () => _pickDateTime(sequence),
                ),
                Padding(padding: Paddings.padding8.horizontal),
                Expanded(
                  child: ref.watch(locationsProvider).when(
                    data: (locations) {
                      return DropdownButtonFormField<Location>(
                        isExpanded: true,
                        hint: Text(localizations.dialog_field_position),
                        value: location,
                        decoration: InputDecoration(
                          label: Text(localizations.dialog_field_position),
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: locations.map<DropdownMenuItem<Location>>((location) {
                          return DropdownMenuItem<Location>(
                            value: location,
                            child: Text(location.getName),
                          );
                        }).toList(),
                        onChanged: (location) => _onLocationSelected(sequence, location),
                      );
                    },
                    loading: () {
                      return CustomPlaceholder.loading();
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return CustomPlaceholder.error();
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(sequence) : null,
              child: TextField(
                controller: title,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_title,
                ),
                onSubmitted: (_) => _onSubmitted(sequence),
              ),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(sequence) : null,
              child: TextField(
                controller: description,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_description,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onSubmitted: (_) => _onSubmitted(sequence),
              ),
            ),
          ],
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return CustomPlaceholder.error();
      },
      loading: () {
        return CustomPlaceholder.loading();
      },
    );
  }
}
