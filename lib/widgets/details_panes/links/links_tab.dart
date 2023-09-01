import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/list_helpers.dart';
import '../../../models/project/link.dart';
import '../../../models/project/project.dart';
import '../../../providers/projects/projects.dart';
import '../../../utils/constants_globals.dart';
import 'link_editor.dart';

class LinksTab extends ConsumerStatefulWidget {
  const LinksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinksEditorState();
}

class _LinksEditorState extends ConsumerState<LinksTab> {
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
    if (moveUpLink.index != null) {
      moveUpLink.index = moveUpLink.index! - 1;
      _edit(moveUpLink);
    }

    if (moveDownLink.index != null) {
      moveDownLink.index = moveDownLink.index! + 1;
      _edit(moveDownLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        project.links?.sort(
          (Link a, Link b) {
            if (a.index == null && b.index == null) {
              return 0;
            } else if (a.index == null) {
              return -1;
            } else if (b.index == null) {
              return 1;
            }

            return a.index!.compareTo(b.index!);
          },
        );

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (project.links != null)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: project.links!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LinkEditor(
                      key: ValueKey(project.links![index]),
                      link: project.links![index],
                      edit: (editedLink) => _edit(editedLink),
                      delete: (id) => _delete(id),
                      moveUp: index != 0 ? () => _move(project.links![index], project.links![index - 1]) : null,
                      moveDown: index != project.links!.length - 1
                          ? () => _move(project.links![index + 1], project.links![index])
                          : null,
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
                  Link newLink = Link.empty(
                    project: project.id,
                    index: project.links!.getNextIndex<Link>(),
                  );
                  project.links!.add(newLink);
                  _add(newLink);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
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
