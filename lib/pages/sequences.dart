import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../widgets/cards/sequence.dart';
import '../widgets/info_headers/episode.dart';
import '../widgets/info_headers/project.dart';
import '../widgets/request_placeholder.dart';

class Sequences extends StatefulWidget {
  const Sequences({super.key, required this.openShots, required this.project, required this.episode});

  final void Function(Sequence sequence) openShots;

  final Project project;
  final Episode episode;

  @override
  State<Sequences> createState() => _SequencesState();
}

class _SequencesState extends State<Sequences> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addSequence,
        child: const Icon(Icons.add),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: <Widget>[
              if (widget.project.isMovie())
                InfoHeaderProject(project: widget.project)
              else
                InfoHeaderEpisode(episode: widget.episode),
              if (widget.episode.sequences.isEmpty)
                Expanded(
                  child: RequestPlaceholder(placeholder: Text('sequences.no_sequences'.tr())),
                )
              else
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                        children: <SequenceCard>[
                      ...widget.episode.sequences.map((Sequence sequence) {
                        return SequenceCard(
                          sequence: sequence,
                          openShots: () {
                            widget.openShots(sequence);
                          },
                        );
                      })
                    ]))
            ],
          );
        },
      ),
    ));
  }

  void addSequence() {
    print('TODO');
  }
}
