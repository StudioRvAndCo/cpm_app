import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../icon_label.dart';
import '../info_sheets/project.dart';

class InfoHeaderProject extends StatelessWidget {
  const InfoHeaderProject({super.key, required this.project});

  final Project project;

  String _getDateText(BuildContext context) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(project.beginDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(project.endDate);
    return '$firstText - $lastText';
  }

  @override
  Widget build(BuildContext context) {
    final Image image = Image.asset('assets/images/en-sursis.png');
    return FilledButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Theme.of(context).colorScheme.background),
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(project.title,
                        style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
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
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
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
            });
      },
    );
  }
}
