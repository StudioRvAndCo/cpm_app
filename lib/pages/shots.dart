import 'package:cpm/extensions/list_helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/shot/shot.dart';
import '../providers/episodes/episodes.dart';
import '../providers/navigation/navigation.dart';
import '../providers/projects/projects.dart';
import '../providers/sequences/sequences.dart';
import '../providers/shots/shots.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/shot_card.dart';
import '../widgets/custom_snack_bars.dart';
import '../widgets/dialogs/shot_dialog.dart';
import '../widgets/info_headers/sequence_info_header.dart';

class Shots extends ConsumerStatefulWidget {
  const Shots({super.key});

  @override
  ConsumerState<Shots> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<Shots> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () => add(), child: const Icon(Icons.add)),
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
                              bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
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
        ),
      ),
    );
  }

  Future<bool> handleBackButton() {
    ref.read(navigationProvider.notifier).set(HomePage.sequences);

    return Future<bool>(() => false);
  }

  Future<void> add() async {
    var currentProjectReader = ref.read(currentProjectProvider);
    var currentEpisodeReader = ref.read(currentEpisodeProvider);
    var currentSequenceReader = ref.read(currentSequenceProvider);

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
      await ref.read(shotsProvider.notifier).add(newShot);
      if (true) {
        final String message = true ? 'snack_bars.episode.deleted'.tr() : 'snack_bars.episode.not_deleted'.tr();
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBars().getModelSnackBar(context, true));
      }
    }
  }
}
