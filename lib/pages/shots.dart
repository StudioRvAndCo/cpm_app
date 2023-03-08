import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/shot.dart';
import '../widgets/cards/shot.dart';

class Shots extends StatefulWidget {
  const Shots({super.key, required this.shots});

  final List<Shot> shots;

  @override
  State<Shots> createState() => _ShotsState();
}

class _ShotsState extends State<Shots> {
  @override
  Widget build(BuildContext context) {
    if (widget.shots.isEmpty) {
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
        children: <ShotCard>[
          for (Shot shot in widget.shots)
            ShotCard(
              shot: shot,
              onPressed: () {},
            )
        ],
      ));
    }
  }
}
