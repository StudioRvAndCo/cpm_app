import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/member.dart';

enum MenuAction { edit, delete }

class MemberTile extends StatefulWidget {
  const MemberTile({super.key, required this.member, required this.onEdit, required this.onDelete});

  final Member member;

  final Function(Member) onEdit;
  final Function(Member) onDelete;

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundImage: AssetImage('assets/placeholder_profile_picture.jpg')),
      title: Text(
        '${widget.member.firstName} ${widget.member.lastName.toUpperCase()}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.member.phone,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse('tel://${widget.member.phone}'));
              },
              icon: const Icon(Icons.phone)),
          IconButton(
              onPressed: () {
                launchUrl(Uri.parse('sms://${widget.member.phone}'));
              },
              icon: const Icon(Icons.message)),
          PopupMenuButton<MenuAction>(
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.edit,
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  )),
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  )),
            ],
            onSelected: (MenuAction action) {
              setState(() {
                switch (action) {
                  case MenuAction.edit:
                    widget.onEdit(widget.member);
                    break;
                  case MenuAction.delete:
                    widget.onDelete(widget.member);
                    break;
                }
              });
            },
          )
        ],
      ),
    );
  }
}
