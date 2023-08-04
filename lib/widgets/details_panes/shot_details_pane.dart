import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/shot/shot_value.dart';
import '../../utils/constants_globals.dart';

class ShotDetailsPane extends ConsumerStatefulWidget {
  const ShotDetailsPane({super.key});

  @override
  ConsumerState<ShotDetailsPane> createState() => _ShotDetailsPaneState();
}

class _ShotDetailsPaneState extends ConsumerState<ShotDetailsPane> {
  TextEditingController descriptionController = TextEditingController();
  final List<String> values = ShotValue.labels();
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentShotProvider).when(
      data: (Shot shot) {
        selectedValue = shot.value?.label;
        descriptionController.text = shot.description ?? '';
        descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                isExpanded: true,
                hint: Text('shots.value.upper'.plural(1)),
                items: values.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                  edit(shot);
                },
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && descriptionController.text != shot.description) {
                    edit(shot);
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

  void edit(Shot shot) {
    shot.value = ShotValue.fromString(selectedValue);
    shot.description = descriptionController.text;

    ref.read(shotsProvider.notifier).edit(shot);
    ref.read(currentShotProvider.notifier).set(shot);
  }
}
