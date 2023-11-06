import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/colored_circle.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotDetailsTab extends ConsumerStatefulWidget {
  const ShotDetailsTab({super.key});

  @override
  ConsumerState<ShotDetailsTab> createState() => _ProjectDetailsTabState();
}

class _ProjectDetailsTabState extends ConsumerState<ShotDetailsTab> {
  final TextEditingController description = TextEditingController();
  ShotValue value = ShotValue.other;

  @override
  void initState() {
    super.initState();

    final shot = ref.read(currentShotProvider).value;
    description.text = shot?.description ?? '';
    if (shot != null && shot.value != null) value = shot.value!;
  }

  void _onValueSelected(Shot shot, ShotValue? newValue) {
    if (newValue == null) return;

    value = newValue;
    _edit(shot);
  }

  void _onSubmitted(Shot shot) {
    if (description.text == shot.description && value == shot.value) return;

    _edit(shot);
  }

  void _edit(Shot shot) {
    shot.description = description.text;
    shot.value = value;

    ref.read(shotsProvider.notifier).edit(shot);
    ref.read(currentShotProvider.notifier).set(shot);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentShotProvider).when(
      data: (shot) {
        return Column(
          children: [
            DropdownButtonFormField<ShotValue>(
              isExpanded: true,
              hint: Text(localizations.dialog_field_value),
              value: value,
              decoration: InputDecoration(
                labelText: localizations.dialog_field_value,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              items: ShotValue.values.map<DropdownMenuItem<ShotValue>>((value) {
                return DropdownMenuItem<ShotValue>(
                  value: value,
                  child: Row(
                    children: [
                      ColoredCircle(color: value.color),
                      Padding(padding: Paddings.padding4.horizontal),
                      Text(value.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) => _onValueSelected(shot, value),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(shot) : null,
              child: TextField(
                controller: description,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_description,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                onSubmitted: (_) => _onSubmitted(shot),
              ),
            ),
          ],
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
