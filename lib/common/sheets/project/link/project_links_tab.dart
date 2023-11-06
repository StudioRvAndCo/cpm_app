import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/sheets/project/link/project_link_editor.dart';
import 'package:cpm/models/project/link.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectLinksTab extends ConsumerStatefulWidget {
  const ProjectLinksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinksEditorState();
}

class _LinksEditorState extends ConsumerState<ProjectLinksTab> {
  void _add(Link link) {
    ref.read(currentProjectProvider.notifier).addLink(link);
  }

  void _edit(Link link) {
    ref.read(currentProjectProvider.notifier).editLink(link);
  }

  void _delete(int id) {
    ref.read(currentProjectProvider.notifier).deleteLink(id);
  }

  void _move(Link moveUpLink, Link moveDownLink) {
    final firstIndex = moveDownLink.index;
    final lastIndex = moveUpLink.index;

    if (moveUpLink.index != null) {
      moveUpLink.index = firstIndex;
      _edit(moveUpLink);
    }

    if (moveDownLink.index != null) {
      moveDownLink.index = lastIndex;
      _edit(moveDownLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (project) {
        project.sortLinks();
        final links = project.links;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (links != null)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: links.length,
                itemBuilder: (BuildContext context, int index) {
                  final link = links[index];

                  return ProjectLinkEditor(
                    key: ValueKey(link),
                    link: link,
                    edit: (editedLink) => _edit(editedLink),
                    delete: (id) => _delete(id),
                    moveUp: index != 0 ? () => _move(link, project.links![index - 1]) : null,
                    moveDown: index != links.length - 1 ? () => _move(project.links![index + 1], link) : null,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                  );
                },
              ),
            IconButton.filledTonal(
              onPressed: () {
                project.links ??= [];
                final Link newLink = Link.empty(
                  project: project.id,
                  index: project.links!.getNextIndex<Link>(),
                );
                project.links!.add(newLink);
                _add(newLink);
              },
              icon: const Icon(Icons.add),
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
  }
}
