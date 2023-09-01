import 'dart:ui';

import 'package:cpm/utils/platform_identifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/project/project.dart';
import '../../providers/navigation/navigation.dart';
import '../../providers/projects/projects.dart';
import '../../utils/constants_globals.dart';
import '../custom_snack_bars.dart';
import '../dialogs/confirm_dialog.dart';
import '../icon_label.dart';
import '../info_sheets/project_info_sheet.dart';

class ProjectInfoHeader extends ConsumerStatefulWidget {
  const ProjectInfoHeader({super.key});

  @override
  ConsumerState<ProjectInfoHeader> createState() => _InfoHeaderProjectState();
}

class _InfoHeaderProjectState extends ConsumerState<ProjectInfoHeader> {
  String _getDateText(BuildContext context, Project project) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(project.getStartDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(project.getEndDate);

    return '$firstText - $lastText';
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        return FilledButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRect(
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: const FittedBox(fit: BoxFit.cover, child: null),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          project.getTitle,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => delete(project),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        project.getDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    IconLabel(
                      text: _getDateText(context, project),
                      icon: Icons.event,
                      iconColor: Theme.of(context).iconTheme.color,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(children: <Widget>[
                      if (project.director != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.movie)),
                        Text(project.director!),
                      ],
                      if (project.writer != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.description)),
                        Text(project.writer!),
                      ],
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Row(
                      children: [
                        const Icon(Icons.link),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: Scrollbar(
                              controller: scrollController,
                              thickness: PlatformIdentifier().isComputer() ? 4 : 0,
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: project.links?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var link = project.links![index];

                                  return TextButton(
                                    onPressed: link.getUrl.isNotEmpty && Uri.tryParse(link.getUrl)!.isAbsolute
                                        ? () {
                                            launchUrlString(link.getUrl, mode: LaunchMode.externalApplication);
                                          }
                                        : null,
                                    child: Text(link.getLabel),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    LinearProgressIndicator(
                      value: project.progress,
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const ProjectInfoSheet();
              },
            );
          },
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

  Future<void> delete(Project project) async {
    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        await ref.read(projectsProvider.notifier).delete(project.id);
        if (true) {
          final String message = true ? 'snack_bars.episode.deleted'.tr() : 'snack_bars.episode.not_deleted'.tr();
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBars().getModelSnackBar(context, true));
        }
        ref.read(navigationProvider.notifier).set(HomePage.projects);
      }
    });
  }
}
