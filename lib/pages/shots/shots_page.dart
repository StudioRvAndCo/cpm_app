import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/sequences/sequence_info_header.dart';
import 'package:cpm/pages/shots/shot_card.dart';
import 'package:cpm/pages/shots/shot_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotsPage extends ConsumerStatefulWidget {
  const ShotsPage({super.key});

  @override
  ConsumerState<ShotsPage> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<ShotsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(shotsProvider).when(
        data: (List<Shot> shots) {
          return Column(
            children: <Widget>[
              const SequenceInfoHeader(),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return MasonryGridView.count(
                      itemCount: shots.length,
                      padding: const EdgeInsets.only(
                        bottom: kFloatingActionButtonMargin + 64,
                        top: 4,
                        left: 4,
                        right: 4,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ShotCard(
                          shot: shots[index],
                        );
                      },
                      crossAxisCount: 1,
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
    final currentProjectReader = ref.read(currentProjectProvider);
    final currentEpisodeReader = ref.read(currentEpisodeProvider);
    final currentSequenceReader = ref.read(currentSequenceProvider);

    if (!currentProjectReader.hasValue || !currentEpisodeReader.hasValue || !currentSequenceReader.hasValue) {
      return;
    }

    final int sequence = currentSequenceReader.value!.id;
    final newShot = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShotDialog(
          sequence: sequence,
          index: ref.read(shotsProvider).value!.getNextIndex<Shot>(),
        );
      },
    );

    if (newShot is Shot) {
      final added = await ref.read(shotsProvider.notifier).add(newShot);
      SnackBarManager().show(
        added ? getInfoSnackBar('snack_bars.shot.added') : getErrorSnackBar('snack_bars.shot.not_added'),
      );
    }
  }
}
