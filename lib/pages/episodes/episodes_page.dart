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
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:cpm/utils/platform.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<EpisodesPage> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<EpisodesPage> {
  Future<void> _refresh() async {
    await ref.read(episodesProvider.notifier).get(refreshing: true);
  }

  Future<void> _open(Episode episode) async {
    ref.read(currentEpisodeProvider.notifier).set(episode);
    if (context.mounted) {
      context.pushNamed(RouterRoute.sequences.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Episode>().add(
          context,
          ref,
          parentId: ref.read(currentProjectProvider).value!.id,
          index: LexoRanker().newRank(previous: ref.read(episodesProvider).value!.lastOrNull?.index),
        ),
        tooltip: localizations.fab_create,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        notificationPredicate: (notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        child: ref.watch(episodesProvider).when(
          data: (episodes) {
            final project = ref.read(currentProjectProvider).valueOrNull;

            final header = ProjectHeader.project(
              delete: () => DeleteAction<Project>().delete(context, ref, id: project?.id),
              title: project?.title,
              description: project?.description,
              dateText: project?.dateText,
              director: project?.director?.fullName,
              writer: project?.writer?.fullName,
              links: project?.links,
            );

            final body = episodes.isEmpty
                ? CustomPlaceholder.empty(EmptyPlaceholder.episodes)
                : ScrollConfiguration(
                    behavior: scrollBehavior,
                    child: ReorderableListView.builder(
                      padding: Paddings.withFab(Paddings.padding8.all),
                      itemCount: episodes.length,
                      proxyDecorator: proxyDecorator,
                      itemBuilder: (context, index) {
                        final episode = episodes[index];

                        return ProjectCard.episode(
                          key: Key('$index'),
                          open: () => _open(episode),
                          number: index + 1,
                          title: episode.title,
                          description: episode.description,
                          progress: episode.progress,
                          progressText: episode.progressText,
                        );
                      },
                      onReorder: (oldIndex, newIndex) => ReorderAction<Episode>().reorder(
                        context,
                        ref,
                        oldIndex: oldIndex,
                        newIndex: newIndex,
                        models: episodes,
                      ),
                    ),
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
