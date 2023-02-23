import 'package:flutter/material.dart';

import '../models/Participant.dart';
import '../widgets/member_tile.dart';

class Participants extends StatefulWidget {
  const Participants({super.key, required this.participants});

  final List<Participant> participants;

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 64,
    endIndent: 16,
    height: 16,
  );

  @override
  Widget build(BuildContext context) {
    final Iterable<ParticipantTile> participantTiles = widget.participants.map((e) => ParticipantTile(participant: e));

    return Expanded(
        child: ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Column(children: <ParticipantTile>[...participantTiles]);
      },
      separatorBuilder: (BuildContext context, int index) => divider,
      itemCount: 1,
    ));
  }
}
