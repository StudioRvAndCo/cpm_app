import 'package:cpm/pages/shots/shot_details_pane.dart';
import 'package:flutter/material.dart';

class ShotInfoSheet extends StatelessWidget {
  const ShotInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: ShotDetailsPane(),
    );
  }
}
