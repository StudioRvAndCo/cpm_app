import 'package:flutter/material.dart';

import '../models/sequence.dart';
import '../widgets/sequence_card.dart';

class Sequences extends StatefulWidget {
  const Sequences({super.key, required this.sequences, required this.openShots});

  final void Function(Sequence sequence) openShots;

  final List<Sequence> sequences;

  @override
  State<Sequences> createState() => _SequencesState();
}

class _SequencesState extends State<Sequences> {
  @override
  Widget build(BuildContext context) {
    if (widget.sequences.isEmpty) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('No sequences.'),
          ],
        ),
      );
    } else {
      return Expanded(
          child: Column(
        children: <SequenceCard>[
          for (Sequence sequence in widget.sequences)
            SequenceCard(
              sequence: sequence,
              openShots: () {
                widget.openShots(sequence);
              },
            )
        ],
      ));
    }
  }
}
