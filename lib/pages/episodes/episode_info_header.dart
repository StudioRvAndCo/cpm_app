import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/pages/episodes/episode_info_sheet.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                    Row(
                      children: <Widget>[
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
                      ],
                    ),
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
                    Row(
                      children: <Widget>[
                        if (episode.director != null) ...<Widget>[
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          const Flexible(child: Icon(Icons.movie)),
                        ],
                        if (episode.writer != null) ...<Widget>[
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          const Flexible(child: Icon(Icons.description)),
                        ],
                      ],
                    ),
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

    showConfirmationDialog(context, 'delete.lower').then((bool? result) async {
      if (result ?? false) {
        final deleted = await ref.read(episodesProvider.notifier).delete(episode.id);
        SnackBarManager().show(
          deleted ? getInfoSnackBar('snack_bars.episode.added') : getErrorSnackBar('snack_bars.episode.not_added'),
        );
        if (context.mounted) {
          context.pushNamed(RouterRoute.episodes.name);
        }
      }
    });
  }
}
