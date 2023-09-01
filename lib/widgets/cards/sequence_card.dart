import 'package:cpm/providers/sequences/sequences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sequence/sequence.dart';
import '../../providers/navigation/navigation.dart';
import '../../utils/constants_globals.dart';

class SequenceCard extends ConsumerStatefulWidget {
  const SequenceCard({super.key, required this.sequence});

  final Sequence sequence;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SequenceCardState();
}

class _SequenceCardState extends ConsumerState<SequenceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: openShots,
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
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            widget.sequence.number.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 12)),
                        Text(
                          widget.sequence.getTitle,
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
          ]),
        ),
      ),
    );
  }

  void openShots() {
    ref.read(currentSequenceProvider.notifier).set(widget.sequence);
    ref.read(navigationProvider.notifier).set(HomePage.shots);
  }
}
