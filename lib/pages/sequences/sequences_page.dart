import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/actions/reorder_action.dart';
import 'package:cpm/common/pages.dart';
import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/common/placeholders/empty_placeholder.dart';
import 'package:cpm/common/widgets/project_card.dart';
import 'package:cpm/common/widgets/project_header.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:cpm/utils/platform.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SequencesPage extends ConsumerStatefulWidget {
  const SequencesPage({super.key});

  @override
  ConsumerState<SequencesPage> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<SequencesPage> {
  Future<void> _refresh() async {
    await ref.read(sequencesProvider.notifier).get(refreshing: true);
  }

  Future<void> _open(Sequence sequence) async {
    ref.read(currentSequenceProvider.notifier).set(sequence);
    if (context.mounted) {
      context.pushNamed(RouterRoute.shots.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Sequence>().add(
          context,
          ref,
          parentId: ref.read(currentEpisodeProvider).value!.id,
          index: LexoRanker().newRank(previous: ref.read(sequencesProvider).value!.lastOrNull?.index),
        ),
        tooltip: localizations.fab_create,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        notificationPredicate: (notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        child: ref.watch(sequencesProvider).when(
          data: (sequences) {
            final project = ref.read(currentProjectProvider).valueOrNull;
            final episode = ref.read(currentEpisodeProvider).valueOrNull;

            Widget header;
            if (project?.isMovie ?? true) {
              header = ProjectHeader.project(
                delete: () => DeleteAction<Project>().delete(context, ref, id: project?.id),
                title: project?.title,
                description: project?.description,
                dateText: project?.dateText,
                director: project?.director?.fullName,
                writer: project?.writer?.fullName,
                links: project?.links,
              );
            } else {
              header = ProjectHeader.episode(
                delete: () => DeleteAction<Episode>().delete(context, ref, id: episode?.id),
                title: episode?.title,
                description: episode?.description,
              );
            }

            final body = sequences.isEmpty
                ? CustomPlaceholder.empty(EmptyPlaceholder.sequences)
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ScrollConfiguration(
                        behavior: scrollBehavior,
                        child: ReorderableListView.builder(
                          padding: Paddings.withFab(Paddings.padding8.all),
                          itemCount: sequences.length,
                          proxyDecorator: proxyDecorator,
                          itemBuilder: (context, index) {
                            final sequence = sequences[index];

                            return ProjectCard.sequence(
                              key: Key('$index'),
                              open: () => _open(sequence),
                              number: index + 1,
                              title: sequence.title,
                              description: sequence.description,
                              progress: sequence.progress,
                              progressText: sequence.progressText,
                            );
                          },
                          onReorder: (oldIndex, newIndex) async {
                            await ReorderAction<Sequence>().reorder(
                              context,
                              ref,
                              oldIndex: oldIndex,
                              newIndex: newIndex,
                              models: sequences,
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
