import 'dart:ui';

import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard.project({
    super.key,
    required this.open,
    required this.title,
    required this.description,
    required this.progress,
    required this.progressText,
    required this.trailing,
  }) : number = null;

  const ProjectCard.episode({
    super.key,
    required this.open,
    required this.number,
    required this.title,
    required this.description,
    required this.progress,
    required this.progressText,
  }) : trailing = null;

  const ProjectCard.sequence({
    super.key,
    required this.open,
    required this.number,
    required this.title,
    required this.description,
    required this.progress,
    required this.progressText,
  }) : trailing = null;

  final Function() open;

  final int? number;
  final String? title;
  final String? description;
  final double progress;
  final String progressText;
  final List<Widget>? trailing;

  @override
  Widget build(BuildContext context) {
    final noNumber = number == null || number! <= 0;
    final noTitle = title == null || title!.isEmpty;
    final noDescription = description == null || description!.isEmpty;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: open,
        child: Padding(
          padding: Paddings.padding8.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (!noNumber) ...[
                    Badge(
                      label: Text('$number'),
                    ),
                    Padding(padding: Paddings.padding4.horizontal),
                  ],
                  Expanded(
                    child: Text(
                      noTitle ? localizations.projects_no_title : title!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontStyle: noTitle ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...?trailing,
                ],
              ),
              Padding(padding: Paddings.padding4.vertical),
              Text(
                noDescription ? localizations.projects_no_description : description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: noDescription ? const TextStyle(fontStyle: FontStyle.italic) : null,
              ),
              Padding(padding: Paddings.padding8.vertical),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      color: Color.lerp(Colors.red, Colors.green, progress),
                    ),
                  ),
                  Padding(padding: Paddings.padding4.horizontal),
                  Text(
                    progressText,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(1, 6, animValue)!;
      final double scale = lerpDouble(1, 1.01, animValue)!;

      return Transform.scale(
        scale: scale,
        child: PhysicalModel(
          elevation: elevation,
          borderRadius: Radiuses.radius16.circular,
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      );
    },
    child: child,
  );
}
