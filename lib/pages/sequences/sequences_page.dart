import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/episodes/episode_info_header.dart';
import 'package:cpm/pages/projects/project_info_header.dart';
import 'package:cpm/pages/sequences/sequence_card.dart';
import 'package:cpm/pages/sequences/sequence_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SequencesPage extends ConsumerStatefulWidget {
  const SequencesPage({super.key});

  @override
  ConsumerState<SequencesPage> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<SequencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(currentProjectProvider).when(
        data: (Project project) {
          return ref.watch(sequencesProvider).when(
            data: (List<Sequence> sequences) {
              return Column(
                children: <Widget>[
                  if (project.isMovie) const ProjectInfoHeader() else const EpisodeInfoHeader(),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return MasonryGridView.count(
                          itemCount: sequences.length,
                          padding: const EdgeInsets.only(
                            bottom: kFloatingActionButtonMargin + 64,
                            top: 4,
                            left: 4,
                            right: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return SequenceCard(sequence: sequences[index]);
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
    if (!ref.read(currentProjectProvider).hasValue ||
        !ref.read(currentEpisodeProvider).hasValue ||
        !ref.read(sequencesProvider).hasValue) {
      return;
    }

    final int episode = ref.read(currentEpisodeProvider).value!.id;
    final result = await showDialog<(Sequence, int?)>(
      context: context,
      builder: (BuildContext context) {
        return SequenceDialog(
          episode: episode,
          index: ref.read(sequencesProvider).value!.getNextIndex<Sequence>(),
        );
      },
    );
    final newSequence = result?.$1;
    final locationId = result?.$2;

    if (newSequence != null) {
      final added = await ref.read(sequencesProvider.notifier).add(newSequence, locationId);
      SnackBarManager().show(
        added
            ? getInfoSnackBar(
                localizations.snack_bar_add_success_item(localizations.item_sequence, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_add_fail_item(localizations.item_sequence, Gender.male.name),
              ),
      );
    }
  }
}
