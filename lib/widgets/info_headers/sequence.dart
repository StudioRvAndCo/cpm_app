import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/sequence.dart';
import '../icon_label.dart';
import '../info_sheets/sequence.dart';

class InfoHeaderSequence extends StatelessWidget {
  const InfoHeaderSequence({super.key, required this.sequence});

  final Sequence sequence;

  String _getDateText(BuildContext context) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(sequence.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(sequence.endDate);
    return '$firstText - $lastText';
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Theme.of(context).colorScheme.background),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(sequence.title,
                        style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(sequence.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis)),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                IconLabel(text: _getDateText(context), icon: Icons.event),
                Row(children: <Widget>[
                  if (sequence.location != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.map))
                  ]
                ])
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
              return InfoSheetSequence(sequence: sequence);
            });
      },
    );
  }
}
