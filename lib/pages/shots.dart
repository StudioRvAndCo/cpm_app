import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/sequence.dart';
import '../models/shot.dart';
import '../widgets/cards/shot.dart';
import '../widgets/info_headers/sequence.dart';

class Shots extends StatefulWidget {
  const Shots({super.key, required this.sequence});

  final Sequence sequence;

  @override
  State<Shots> createState() => _ShotsState();
}

class _ShotsState extends State<Shots> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () => addShot),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (widget.sequence.shots.isEmpty) {
            return Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('shots.no_shots'.tr()),
                ],
              ),
            );
          } else {
            return Expanded(
                child: Column(
              children: <Widget>[
                InfoHeaderSequence(sequence: widget.sequence),
                for (Shot shot in widget.sequence.shots)
                  ShotCard(
                    shot: shot,
                    onPressed: () {},
                  )
              ],
            ));
          }
        },
      ),
    ));
  }

  void addShot() {
    print('TODO');
  }
}
