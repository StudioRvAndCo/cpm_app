import 'package:flutter/material.dart';

import '../models/sequence.dart';

class SequenceCard extends StatefulWidget {
  const SequenceCard({super.key, required this.sequence, required this.openShots});

  final void Function() openShots;

  final Sequence sequence;

  @override
  State<StatefulWidget> createState() => _SequenceCardState();
}

class _SequenceCardState extends State<SequenceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          onPressed: widget.openShots,
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: const BorderRadius.all(Radius.circular(15))),
                              child: Text(widget.sequence.number.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.onSecondary)),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 12)),
                            Text(
                              widget.sequence.title,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 4)),
                        Text(
                          widget.sequence.description ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ]),
              ])),
        ));
  }
}
