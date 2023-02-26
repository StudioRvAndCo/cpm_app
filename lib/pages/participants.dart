import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../exceptions/invalid_direction_exception.dart';
import '../models/participant.dart';
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
    height: 0,
  );

  @override
  Widget build(BuildContext context) {
    final Iterable<ParticipantTile> participantsTiles =
        widget.participants.map((Participant participant) => ParticipantTile(
              participant: participant,
              onEdit: (Participant participant) {
                edit(participant);
              },
              onDelete: (Participant participant) async {
                if (await showConfirmationDialog(context, 'delete') ?? false) {
                  delete(participant);
                }
              },
            ));

    return Expanded(
        child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => divider,
      itemCount: participantsTiles.length,
      itemBuilder: (BuildContext context, int index) => ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            final Participant participant = participantsTiles.elementAt(index).participant;
            switch (direction) {
              case DismissDirection.endToStart:
                edit(participant);
                break;
              case DismissDirection.startToEnd:
                delete(participant);
                break;
              case DismissDirection.vertical:
              case DismissDirection.horizontal:
              case DismissDirection.up:
              case DismissDirection.down:
              case DismissDirection.none:
                throw InvalidDirectionException('Invalid direction');
            }
          },
          confirmDismiss: (DismissDirection dismissDirection) async {
            switch (dismissDirection) {
              case DismissDirection.endToStart:
                return true;
              case DismissDirection.startToEnd:
                return await showConfirmationDialog(context, 'delete') ?? false == true;
              case DismissDirection.horizontal:
              case DismissDirection.vertical:
              case DismissDirection.up:
              case DismissDirection.down:
              case DismissDirection.none:
                assert(false);
            }
            return false;
          },
          background: deleteBackground(),
          secondaryBackground: editBackground(),
          child: participantsTiles.elementAt(index),
        ),
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
}
