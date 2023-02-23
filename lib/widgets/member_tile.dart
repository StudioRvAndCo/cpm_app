import 'package:flutter/material.dart';

import '../models/Participant.dart';

class ParticipantTile extends StatefulWidget {
  const ParticipantTile({super.key, required this.participant});

  final Participant participant;

  @override
  State<ParticipantTile> createState() => _ParticipantTileState();
}

class _ParticipantTileState extends State<ParticipantTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const CircleAvatar(backgroundImage: AssetImage('assets/placeholder_profile_picture.jpg')),
          title: Text(
            '${widget.participant.firstName} ${widget.participant.lastName.toUpperCase()}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            widget.participant.phone,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    print('call');
                  },
                  icon: const Icon(Icons.phone)),
              IconButton(
                  onPressed: () {
                    print('call');
                  },
                  icon: const Icon(Icons.message)),
              IconButton(
                  onPressed: () {
                    print('call');
                  },
                  icon: const Icon(Icons.more_horiz))
            ],
          ),
        ),
      ],
    );
  }
}
