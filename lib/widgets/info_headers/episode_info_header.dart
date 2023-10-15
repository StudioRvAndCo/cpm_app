import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode/episode.dart';
import '../../providers/episodes/episodes.dart';
import '../../providers/navigation/navigation.dart';
import '../../providers/projects/projects.dart';
import '../../utils/constants_globals.dart';
import '../../utils/snack_bar_manager/custom_snack_bar.dart';
import '../../utils/snack_bar_manager/snack_bar_manager.dart';
import '../dialogs/confirm_dialog.dart';
import '../info_sheets/episode_info_sheet.dart';

class EpisodeInfoHeader extends ConsumerStatefulWidget {
  const EpisodeInfoHeader({super.key});

  @override
  ConsumerState<EpisodeInfoHeader> createState() => _InfoHeaderEpisodeState();
}

class _InfoHeaderEpisodeState extends ConsumerState<EpisodeInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentEpisodeProvider).when(
      data: (Episode episode) {
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
                          episode.getTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => delete(episode),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        episode.getDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(children: <Widget>[
                      if (episode.director != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.movie)),
                      ],
                      if (episode.writer != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.description)),
                      ],
                    ]),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const EpisodeInfoSheet();
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

  Future<void> delete(Episode episode) async {
    if (!ref.read(currentProjectProvider).hasValue) {
      return;
    }

    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final deleted = await ref.read(episodesProvider.notifier).delete(episode.id);
        SnackBarManager().show(deleted
            ? CustomSnackBar.getInfoSnackBar('snack_bars.episode.added'.tr())
            : CustomSnackBar.getErrorSnackBar('snack_bars.episode.not_added'.tr()));
        ref.read(navigationProvider.notifier).set(HomePage.episodes);
      }
    });
  }
}
