import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'icon_label.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader(
      {super.key,
      required this.title,
      required this.description,
      required this.dateRange,
      required this.progress,
      required this.leftLabel,
      this.rightLabel,
      this.image,
      this.cornerButton});

  final DateTimeRange dateRange;
  final String title;
  final String description;
  final Image? image;
  final IconLabel leftLabel;
  final IconLabel? rightLabel;
  final double progress;
  final IconButton? cornerButton;

  String _getDateText() {
    final String firstText =
        DateFormat.yMd(Intl.systemLocale).format(dateRange.start);
    final String lastText =
        DateFormat.yMd(Intl.systemLocale).format(dateRange.end);
    return '$firstText - $lastText';
  }

  Widget _getTitle(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _getBottomRow() {
    if (rightLabel == null) {
      return leftLabel;
    } else {
      return Row(
        children: <Widget>[
          Flexible(child: leftLabel),
          Flexible(child: rightLabel!)
        ],
      );
    }
  }

  Widget _getCardContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (cornerButton == null)
              _getTitle(context)
            else
              Row(children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: _getTitle(context),
                ),
                cornerButton!
              ]),
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            IconLabel(text: _getDateText(), icon: Icons.event),
            const SizedBox(height: 8),
            _getBottomRow(),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const Border(),
        child: image == null
            ? _getCardContent(context)
            : Stack(
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
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: FittedBox(fit: BoxFit.cover, child: image),
                      ),
                    ),
                  )),
                  _getCardContent(context),
                ],
              ));
  }
}
