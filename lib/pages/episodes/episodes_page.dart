import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/pages/episodes/episode_card.dart';
import 'package:cpm/pages/episodes/episode_dialog.dart';
import 'package:cpm/pages/projects/project_info_header.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<EpisodesPage> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<EpisodesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(episodesProvider).when(
        data: (List<Episode> episodes) {
          return Column(
            children: <Widget>[
              const ProjectInfoHeader(),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return MasonryGridView.count(
                      itemCount: episodes.length,
                      padding:
                          const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return EpisodeCard(episode: episodes[index]);
                      },
                      crossAxisCount: getColumnsCount(constraints),
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    );
                  },
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
      ),
    );
  }

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(episodesProvider).hasValue) {
      return;
    }

    final int project = ref.read(currentProjectProvider).value!.id;
    final newEpisode = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EpisodeDialog(
          project: project,
          index: ref.read(episodesProvider).value!.getNextIndex<Episode>(),
        );
      },
    );
    if (newEpisode is Episode) {
      final added = await ref.read(episodesProvider.notifier).add(newEpisode);
      SnackBarManager().show(
        added ? getInfoSnackBar('snack_bars.episode.added') : getErrorSnackBar('snack_bars.episode.not_added'),
      );
    }
  }
}
