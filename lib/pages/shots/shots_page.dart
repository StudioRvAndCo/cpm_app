import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/project_header.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/shots/shot_card.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/pages.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotsPage extends ConsumerStatefulWidget {
  const ShotsPage({super.key});

  @override
  ConsumerState<ShotsPage> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<ShotsPage> {
  Future<void> _refresh() async {
    await ref.read(shotsProvider.notifier).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Shot>().add(
          context,
          ref,
          parentId: ref.read(currentSequenceProvider).value!.id,
          index: ref.read(shotsProvider).value!.getNextIndex<Sequence>(),
        ),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        notificationPredicate: (notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        child: ref.watch(shotsProvider).when(
          data: (shots) {
            final sequence = ref.watch(currentSequenceProvider).unwrapPrevious().valueOrNull;

            final header = ProjectHeader.sequence(
              delete: () => DeleteAction<Sequence>().delete(context, ref, id: sequence?.id),
              title: sequence?.title,
              description: sequence?.description,
              startDate: sequence?.startDate,
              endDate: sequence?.endDate,
              location: sequence?.location,
            );

            final body = LayoutBuilder(
              builder: (context, constraints) {
                return ScrollConfiguration(
                  behavior: scrollBehavior,
                  child: AlignedGridView.count(
                    crossAxisCount: getColumnsCount(constraints),
                    itemCount: shots.length,
                    itemBuilder: (context, index) {
                      return ShotCard(shots[index]);
                    },
                    padding: Paddings.withFab(Paddings.padding8.all),
                  ),
                );
              },
            );

            return PlatformManager().isMobile
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
            return requestPlaceholderError;
          },
          loading: () {
            return requestPlaceholderLoading;
          },
        ),
      ),
    );
  }
}
