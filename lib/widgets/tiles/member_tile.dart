import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/member.dart';

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
      leading: SizedBox(
          width: 50,
          height: 50,
          child: Builder(builder: (BuildContext context) {
            if (widget.member.image != null) {
              return Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(fit: BoxFit.cover, image: widget.member.image!.image)));
            } else {
              return Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              );
            }
          })),
      title: Text(
        '${widget.member.firstName} ${widget.member.lastName!.toUpperCase()}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        widget.member.phone!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              tooltip: 'members.call'.tr(),
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: checkPhone()
                  ? () {
                      launchUrl(Uri.parse('tel://${widget.member.phone}'));
                    }
                  : null,
              icon: const Icon(Icons.phone)),
          IconButton(
              tooltip: 'members.message'.tr(),
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: checkPhone()
                  ? () {
                      launchUrl(Uri.parse('sms://${widget.member.phone}'));
                    }
                  : null,
              icon: const Icon(Icons.message)),
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
                    title: Text('edit.upper'.tr()),
                  )),
              PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text('delete.upper'.tr()),
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

  bool checkPhone() {
    return widget.member.phone != null && widget.member.phone != '';
  }
}
