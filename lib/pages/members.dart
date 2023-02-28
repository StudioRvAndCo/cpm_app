import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../dialogs/new_edit_member.dart';
import '../exceptions/invalid_direction_exception.dart';
import '../models/member.dart';
import '../widgets/member_tile.dart';

class Members extends StatefulWidget {
  const Members({super.key, required this.members});

  final List<Member> members;

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  late final List<Member> members;

  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    height: 0,
  );

  @override
  void initState() {
    members = widget.members;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<MemberTile> membersTiles =
        members.map((Member member) => MemberTile(
              member: member,
              onEdit: (Member member) {
                edit(member);
              },
              onDelete: (Member member) async {
                if (await showConfirmationDialog(context, 'delete') ?? false) {
                  delete(member);
                }
              },
            ));

    return Expanded(
        child: Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: add, child: const Icon(Icons.add)),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => divider,
        itemCount: membersTiles.length,
        itemBuilder: (BuildContext context, int index) => ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) {
              final Member member = membersTiles.elementAt(index).member;
              switch (direction) {
                case DismissDirection.endToStart:
                  edit(member);
                  break;
                case DismissDirection.startToEnd:
                  delete(member);
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
                  return await showConfirmationDialog(context, 'delete') ??
                      false == true;
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
            child: membersTiles.elementAt(index),
          ),
        ),
      ),
    ));
  }

  void edit(Member member) {
    showDialog<Member>(
        context: context,
        builder: (BuildContext context) {
          return MemberDialog(
              edit: true,
              firstName: member.firstName,
              lastName: member.lastName,
              telephone: member.phone,
              image: member.image);
        }).then(
      (Member? result) {
        if (result != null) {
          setState(() {
            member.firstName = result.firstName;
            member.lastName = result.lastName;
            member.phone = result.phone;
            member.image = result.image;
          });
        }
      },
    );
  }

  void delete(Member member) {
    setState(() {
      widget.members.remove(member);
    });
  }

  void add() {
    showDialog<Member>(
        context: context,
        builder: (BuildContext context) {
          return const MemberDialog(
            edit: false,
          );
        }).then(
      (Member? result) {
        if (result != null) {
          setState(() {
            final Member member = Member(
                firstName: result.firstName,
                lastName: result.lastName,
                phone: result.phone,
                image: result.image);
            members.add(member);
          });
        }
      },
    );
  }
}
