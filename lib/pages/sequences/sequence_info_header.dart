import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/icon_label.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/sequences/sequence_info_sheet.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

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
                    Row(
                      children: <Widget>[
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
                      ],
                    ),
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
                          '${DateFormat.yMd(localizations.localeName).format(sequence.getDate)} | ${sequence.getStartTime.format(context)} - ${sequence.getEndTime.format(context)}',
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

    showConfirmationDialog(context, 'delete.lower').then((bool? result) async {
      if (result ?? false) {
        final deleted = await ref.read(sequencesProvider.notifier).delete(sequence.id);
        SnackBarManager().show(
          deleted ? getInfoSnackBar('snack_bars.sequence.added') : getErrorSnackBar('snack_bars.sequence.not_added'),
        );
        if (context.mounted) {
          context.pushNamed(RouterRoute.episodes.name);
        }
      }
    });
  }
}
