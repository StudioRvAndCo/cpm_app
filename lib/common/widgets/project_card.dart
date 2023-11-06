import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard.project({
    super.key,
    required this.open,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
    required this.trailing,
  }) : number = null;

  const ProjectCard.episode({
    super.key,
    required this.open,
    required this.number,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
  }) : trailing = null;

  const ProjectCard.sequence({
    super.key,
    required this.open,
    required this.number,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
  }) : trailing = null;

  final Function() open;

  final String? number;
  final String? title;
  final String? description;
  final double progress;
  final String? progressText;
  final List<Widget>? trailing;

  @override
  Widget build(BuildContext context) {
    final noNumber = number == null || number!.isEmpty;
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
                      label: Text(number!),
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
                  if (progressText != null) ...[
                    Padding(padding: Paddings.padding4.horizontal),
                    Text(
                      progressText!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
