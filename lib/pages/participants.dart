import 'package:flutter/material.dart';

import '../exceptions/invalid_direction_exception.dart';
import '../models/Participant.dart';
import '../widgets/participant_tile.dart';

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
    indent: 16,
    endIndent: 16,
    height: 16,
  );

  void deleteParticipant(Participant participant) {
    widget.participants.remove(participant);
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<ParticipantTile> participantTiles =
        widget.participants.map((Participant participantTile) => ParticipantTile(
              participant: participantTile,
              onEdit: (Participant participant) {
                edit(participant);
              },
              onDelete: (Participant participant) {
                delete(participant);
              },
            ));

    return Expanded(
        child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => divider,
      itemCount: participantTiles.length,
      itemBuilder: (BuildContext context, int index) => Dismissible(
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          final Participant participant = participantTiles.elementAt(index).participant;
          switch (direction) {
            case DismissDirection.endToStart:
              edit(participant);
              break;
            case DismissDirection.startToEnd:
              delete(participant);
              break;
            case DismissDirection.vertical:
              throw InvalidDirectionException('Invalid direction: ${DismissDirection.vertical}');
            case DismissDirection.horizontal:
              throw InvalidDirectionException('Invalid direction: ${DismissDirection.horizontal}');
            case DismissDirection.up:
              throw InvalidDirectionException('Invalid direction: ${DismissDirection.up}');
            case DismissDirection.down:
              throw InvalidDirectionException('Invalid direction: ${DismissDirection.down}');
            case DismissDirection.none:
              throw InvalidDirectionException('Invalid direction: ${DismissDirection.none}');
          }
        },
        background: deleteBackground(),
        secondaryBackground: editBackground(),
        child: participantTiles.elementAt(index),
      ),
    ));
  }

  void edit(Participant participant) {
    setState(() {
      print('edit $participant');
    });
  }

  void delete(Participant participant) {
    setState(() {
      widget.participants.remove(participant);
    });
  }

  Widget deleteBackground() {
    return const ColoredBox(
      color: Colors.red,
      child: Align(alignment: Alignment.centerLeft, child: ListTile(leading: Icon(Icons.delete, color: Colors.white))),
    );
  }

  Widget editBackground() {
    return const ColoredBox(
      color: Colors.blue,
      child: Align(alignment: Alignment.centerLeft, child: ListTile(trailing: Icon(Icons.edit, color: Colors.white))),
    );
  }
}
