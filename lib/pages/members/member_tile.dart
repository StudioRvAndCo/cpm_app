import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
        ),
        title: Text(
          widget.member.fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: hasPhone()
            ? Text(
                widget.member.phone!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              tooltip: localizations.members_call,
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: hasPhone()
                  ? () {
                      launchUrl(Uri.parse('tel://${widget.member.phone}'));
                    }
                  : null,
              icon: const Icon(Icons.phone),
            ),
            IconButton(
              tooltip: localizations.members_message,
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: hasPhone()
                  ? () {
                      launchUrl(Uri.parse('sms://${widget.member.phone}'));
                    }
                  : null,
              icon: const Icon(Icons.message),
            ),
            PopupMenuButton<MenuAction>(
              icon: Icon(
                Icons.more_horiz,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
                PopupMenuItem<MenuAction>(
                  value: MenuAction.edit,
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text(localizations.menu_edit),
                  ),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text(localizations.menu_delete),
                  ),
                ),
              ],
              onSelected: (MenuAction action) {
                setState(() {
                  switch (action) {
                    case MenuAction.edit:
                      widget.onEdit(widget.member);
                    case MenuAction.delete:
                      widget.onDelete(widget.member);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  bool hasPhone() {
    final String? phone = widget.member.phone;

    return phone != null && phone.isNotEmpty;
  }
}
