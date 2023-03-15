import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../dialogs/confirm_dialog.dart';
import '../../models/project.dart';
import '../../pages/home.dart';
import '../../services/project.dart';
import '../icon_label.dart';
import '../info_sheets/project.dart';
import '../snack_bars.dart';

class InfoHeaderProject extends StatefulWidget {
  const InfoHeaderProject({super.key, required this.project});

  final Project project;

  @override
  State<InfoHeaderProject> createState() => _InfoHeaderProjectState();
}

class _InfoHeaderProjectState extends State<InfoHeaderProject> {
  late Project project;

  @override
  void initState() {
    super.initState();
    project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset('assets/images/en-sursis.png');
    return FilledButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .background),
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
                        Colors.transparent
                      ],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: FittedBox(fit: BoxFit.cover, child: image),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        project.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: deleteProject,
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(project.description, maxLines: 2, overflow: TextOverflow.ellipsis)),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                IconLabel(text: _getDateText(context), icon: Icons.event),
                Row(children: <Widget>[
                  if (project.director != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.movie_outlined))
                  ],
                  if (project.writer != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.description_outlined))
                  ]
                ]),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                LinearProgressIndicator(
                  value: project.getProgress(),
                  backgroundColor: Theme
                      .of(context)
                      .colorScheme
                      .onPrimaryContainer,
                )
              ],
            ),
          ),
          //_getCardContent(context),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return InfoSheetProject(project: project);
            }).then((_) => refresh());
      },
    );
  }

  Future<void> refresh() async {
    final List<dynamic> result = await ProjectService().getCompleteProject(widget.project.id);
    setState(() {
      project = result[1] as Project;
    });
  }

   Future<void> deleteProject() async {
    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final List<dynamic> result = await ProjectService().deleteProject(widget.project.id);
        if (context.mounted) {
          final bool succeeded = result[0] as bool;
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, result[1] as int,
              message: succeeded ? 'snack_bars.project.deleted'.tr() : 'snack_bars.project.not_deleted'.tr()));
        }
        resetPage();
      }
    });
  }

  String _getDateText(BuildContext context) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(project.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(project.endDate);
    return '$firstText - $lastText';
  }
}
