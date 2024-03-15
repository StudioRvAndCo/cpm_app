import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/actions/reorder_action.dart';
import 'package:cpm/common/pages.dart';
import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/common/placeholders/empty_placeholder.dart';
import 'package:cpm/common/widgets/project_card.dart';
import 'package:cpm/common/widgets/project_header.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/shots/shot_card.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:cpm/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotsPage extends ConsumerStatefulWidget {
  const ShotsPage({super.key});

  @override
  ConsumerState<ShotsPage> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<ShotsPage> {
  Future<void> _refresh() async {
    await ref.read(shotsProvider.notifier).get(refreshing: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Shot>().add(
          context,
          ref,
          parentId: ref.read(currentSequenceProvider).value!.id,
          index: LexoRanker().newRank(previous: ref.read(shotsProvider).value!.lastOrNull?.index),
        ),
        tooltip: localizations.fab_create,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        notificationPredicate: (notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        child: ref.watch(shotsProvider).when(
          data: (shots) {
            final sequence = ref.read(currentSequenceProvider).valueOrNull;

            final header = ProjectHeader.sequence(
              delete: () => DeleteAction<Sequence>().delete(context, ref, id: sequence?.id),
              title: sequence?.title,
              description: sequence?.description,
              dateText: sequence?.dateText,
              location: sequence?.location,
            );

            final body = shots.isEmpty
                ? CustomPlaceholder.empty(EmptyPlaceholder.shots)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ScrollConfiguration(
                        behavior: scrollBehavior,
                        child: ReorderableListView.builder(
                          padding: Paddings.withFab(Paddings.padding8.all),
                          itemCount: shots.length,
                          proxyDecorator: proxyDecorator,
                          itemBuilder: (context, index) {
                            return ShotCard(
                              key: Key('$index'),
                              index,
                              shots[index],
                            );
                          },
                          onReorder: (oldIndex, newIndex) async {
                            await ReorderAction<Shot>().reorder(
                              context,
                              ref,
                              oldIndex: oldIndex,
                              newIndex: newIndex,
                              models: shots,
                            );
                            setState(() {});
                          },
                        ),
                      );
                    },
                  );

            return kIsMobile
                ? NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: header,
                        ),
                      ];
                    },
                    body: body,
                  )
                : Column(
                    children: [
                      header,
                      Expanded(child: body),
                    ],
                  );
          },
          error: (Object error, StackTrace stackTrace) {
            return CustomPlaceholder.error();
          },
          loading: () {
            return CustomPlaceholder.loading();
          },
        ),
      ),
    );
  }
}
