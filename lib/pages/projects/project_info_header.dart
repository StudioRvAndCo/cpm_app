import 'dart:ui';

import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/icon_label.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/pages/projects/project_info_sheet.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectInfoHeader extends ConsumerStatefulWidget {
  const ProjectInfoHeader({super.key});

  @override
  ConsumerState<ProjectInfoHeader> createState() => _InfoHeaderProjectState();
}

class _InfoHeaderProjectState extends ConsumerState<ProjectInfoHeader> {
  String _getDateText(BuildContext context, Project project) {
    final String firstText = DateFormat.yMd(localizations.localeName).format(project.getStartDate);
    final String lastText = DateFormat.yMd(localizations.localeName).format(project.getEndDate);

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
                      child: const FittedBox(fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
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
                      ],
                    ),
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
                    Row(
                      children: <Widget>[
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
                      ],
                    ),
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
                              thickness: !PlatformManager().isMobile ? 4 : 0,
                              child: ListView.builder(
                                controller: scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: project.links?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final link = project.links![index];

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
    showConfirmationDialog(context, project.getTitle).then((bool? result) async {
      if (result ?? false) {
        final deleted = await ref.read(projectsProvider.notifier).delete(project.id);
        SnackBarManager().show(
          deleted
              ? getInfoSnackBar(
                  localizations.snack_bar_delete_success_item(localizations.item_project, Gender.male.name),
                )
              : getErrorSnackBar(
                  localizations.snack_bar_delete_fail_item(localizations.item_project, Gender.male.name),
                ),
        );
        if (context.mounted) {
          context.pushNamed(RouterRoute.projects.name);
        }
      }
    });
  }
}
