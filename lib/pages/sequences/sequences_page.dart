import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/projects/project_card.dart';
import 'package:cpm/common/widgets/projects/project_header.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SequencesPage extends ConsumerStatefulWidget {
  const SequencesPage({super.key});

  @override
  ConsumerState<SequencesPage> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<SequencesPage> {
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
          index: ref.read(sequencesProvider).value!.getNextIndex<Sequence>(),
        ),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(sequencesProvider).when(
        data: (List<Sequence> sequences) {
          final project = ref.watch(currentProjectProvider).unwrapPrevious().valueOrNull;
          final episode = ref.watch(currentEpisodeProvider).unwrapPrevious().valueOrNull;

          Widget header;
          if (project?.isMovie ?? true) {
            header = ProjectHeader.project(
              delete: () => DeleteAction<Project>().delete(context, ref, id: project?.id),
              title: project?.title,
              description: project?.description,
              startDate: project?.startDate,
              endDate: project?.endDate,
            );
          } else {
            header = ProjectHeader.episode(
              delete: () => DeleteAction<Episode>().delete(context, ref, id: episode?.id),
              title: episode?.title,
              description: episode?.description,
            );
          }

          final body = LayoutBuilder(
            builder: (context, constraints) {
              return AlignedGridView.count(
                crossAxisCount: getColumnsCount(constraints),
                itemCount: sequences.length,
                itemBuilder: (context, index) {
                  final episode = sequences[index];

                  return ProjectCard.sequence(
                    key: UniqueKey(),
                    open: () => _open(episode),
                    number: episode.getNumber,
                    title: episode.title,
                    description: episode.description,
                    progress: 0,
                    progressText: '',
                  );
                },
                padding: Paddings.withFab(Paddings.padding8.all),
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
    );
  }
}
