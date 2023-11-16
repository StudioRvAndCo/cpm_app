import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddSequenceDialog extends ConsumerStatefulWidget {
  const AddSequenceDialog({
    super.key,
    required this.episodeId,
    required this.index,
  });

  final int episodeId;
  final int index;

  @override
  ConsumerState<AddSequenceDialog> createState() => _AddSequenceState();
}

class _AddSequenceState extends ConsumerState<AddSequenceDialog> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  late DateTime date;
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now().hourLater;
  Location? location;

  @override
  void initState() {
    super.initState();

    final project = ref.read(currentProjectProvider).value;
    date = project?.startDate ?? DateTime.now();
  }

  Future<void> _pickDateTime() async {
    final project = ref.read(currentProjectProvider).value;

    await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: project?.startDate ?? DateTime.now().hundredYearsBefore,
      lastDate: project?.endDate ?? DateTime.now().hundredYearsLater,
    ).then((pickedDate) async {
      if (pickedDate == null) return;

      await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: localizations.dialog_field_start_time,
      ).then((pickedStartTime) async {
        if (pickedStartTime == null) return;

        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          helpText: localizations.dialog_field_end_time,
        ).then((pickedEndTime) {
          if (pickedEndTime == null) return;

          setState(() {
            date = pickedDate;
            startTime = pickedStartTime;
            endTime = pickedEndTime;
          });
        });
      });
    });
  }

  void _onLocationSelected(Location? newLocation) {
    if (newLocation == null) return;

    setState(() {
      location = newLocation;
    });
  }

  void _cancel(BuildContext context) {
    context.pop();
  }

  void _add(BuildContext context) {
    context.pop(
      (
        Sequence(
          episode: widget.episodeId,
          index: widget.index,
          title: title.text,
          description: description.text,
          startDate: DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute),
          endDate: DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute),
        ),
        location?.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      cancel: () => _cancel(context),
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_sequence, Gender.female.name),
      action: localizations.button_add,
      fields: [
        TextField(
          controller: title,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_title,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: description,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_description,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        ref.watch(locationsProvider).when(
          data: (locations) {
            return DropdownButtonFormField<Location>(
              isExpanded: true,
              hint: Text(localizations.dialog_field_position),
              value: location,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              items: locations.map<DropdownMenuItem<Location>>((location) {
                return DropdownMenuItem<Location>(
                  value: location,
                  child: Text(location.getName),
                );
              }).toList(),
              onChanged: _onLocationSelected,
            );
          },
          loading: () {
            return requestPlaceholderLoading;
          },
          error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          },
        ),
        Padding(padding: Paddings.padding8.vertical),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.calendar_month),
                label: Text('${date.yMd} | ${startTime.format(context)} - ${endTime.format(context)}'),
                onPressed: _pickDateTime,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
