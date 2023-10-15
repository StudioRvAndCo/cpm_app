import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sequence/sequence.dart';
import '../../providers/episodes/episodes.dart';
import '../../providers/navigation/navigation.dart';
import '../../providers/projects/projects.dart';
import '../../providers/sequences/sequences.dart';
import '../../utils/constants_globals.dart';
import '../../utils/snack_bar_manager/custom_snack_bar.dart';
import '../../utils/snack_bar_manager/snack_bar_manager.dart';
import '../dialogs/confirm_dialog.dart';
import '../icon_label.dart';
import '../info_sheets/sequence_info_sheet.dart';

class SequenceInfoHeader extends ConsumerStatefulWidget {
  const SequenceInfoHeader({super.key});

  @override
  ConsumerState<SequenceInfoHeader> createState() => _InfoHeaderSequenceState();
}

class _InfoHeaderSequenceState extends ConsumerState<SequenceInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) {
        return FilledButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          sequence.getTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => delete(sequence),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        sequence.description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    IconLabel(
                      text:
                          '${DateFormat.yMd(context.locale.toString()).format(sequence.getDate)} | ${sequence.getStartTime.format(context)} - ${sequence.getEndTime.format(context)}',
                      icon: Icons.event,
                    ),
                    if (sequence.location != null) IconLabel(text: sequence.location!.getName, icon: Icons.map),
                  ],
                ),
              ),
              //_getCardContent(context),
            ],
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const SequenceInfoSheet();
              },
            );
          },
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

  Future<void> delete(Sequence sequence) async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(currentEpisodeProvider).hasValue) {
      return;
    }

    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final deleted = await ref.read(sequencesProvider.notifier).delete(sequence.id);
        SnackBarManager().show(deleted
            ? CustomSnackBar.getInfoSnackBar('snack_bars.sequence.added'.tr())
            : CustomSnackBar.getErrorSnackBar('snack_bars.sequence.not_added'.tr()));
        ref.read(navigationProvider.notifier).set(HomePage.episodes);
      }
    });
  }
}
