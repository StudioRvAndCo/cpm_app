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
  late DateTime start;
  late DateTime end;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Location? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) {
        start = sequence.getStartDate;
        end = sequence.getEndDate;
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
                  text: getDateText(),
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

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(end);

    return '$firstText - $lastText';
  }

  Future<void> editDate(Sequence sequence) async {
    final DateTimeRange? newDates = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newDates != null) {
      setState(() {
        start = newDates.start;
        end = newDates.end;
      });
    }
    edit(sequence);
  }

  void edit(Sequence sequence) {
    sequence.title = titleController.text;
    sequence.description = descriptionController.text;
    sequence.startDate = start;
    sequence.endDate = end;
    sequence.location = selectedLocation;

    ref.read(sequencesProvider.notifier).edit(sequence, selectedLocation?.id);
    ref.read(currentSequenceProvider.notifier).set(sequence);
  }
}
