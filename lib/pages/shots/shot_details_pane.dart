import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotDetailsPane extends ConsumerStatefulWidget {
  const ShotDetailsPane({super.key});

  @override
  ConsumerState<ShotDetailsPane> createState() => _ShotDetailsPaneState();
}

class _ShotDetailsPaneState extends ConsumerState<ShotDetailsPane> {
  TextEditingController descriptionController = TextEditingController();
  final List<String> values = ShotValue.labels();
  String? selectedValue;

  void _edit(Shot shot) {
    shot.value = ShotValue.fromString(selectedValue);
    shot.description = descriptionController.text;

    ref.read(shotsProvider.notifier).edit(shot);
    ref.read(currentShotProvider.notifier).set(shot);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentShotProvider).when(
      data: (shot) {
        selectedValue = shot.value?.label;
        descriptionController.text = shot.description ?? '';
        descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      hint: Text(localizations.dialog_field_value),
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
                        _edit(shot);
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () => DeleteAction<Shot>().delete(context, ref, id: shot.id),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && descriptionController.text != shot.description) {
                    _edit(shot);
                  }
                },
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration.collapsed(hintText: localizations.dialog_field_description),
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
}
