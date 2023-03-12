import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../dialogs/new_edit_member.dart';
import '../exceptions/invalid_direction_exception.dart';
import '../models/member.dart';
import '../services/member.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/snack_bars.dart';
import '../widgets/tiles/member_tile.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool requestCompleted = false;
  late bool requestSucceeded;
  List<Member> members = <Member>[];

  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    height: 0,
  );

  @override
  void initState() {
    super.initState();
    getMembers();
  }

  @override
  Widget build(BuildContext context) {
    if (!requestCompleted) {
      return const Expanded(child: RequestPlaceholder(placeholder: CircularProgressIndicator()));
    } else if (requestSucceeded) {
      return Expanded(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: addMember,
                child: const Icon(Icons.add),
              ),
              body: Builder(builder: (BuildContext context) {
                if (members.isEmpty) {
                  return RequestPlaceholder(placeholder: Text('members.no_members'.tr()));
                } else {
                  final Iterable<MemberTile> membersTiles = members.map((Member member) => MemberTile(
                        member: member,
                        onEdit: (Member member) {
                          editMember(member);
                        },
                        onDelete: (Member member) {
                          showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) {
                            if (result ?? false) {
                              deleteMember(member);
                            }
                          });
                        },
                      ));
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                    separatorBuilder: (BuildContext context, int index) => divider,
                    itemCount: membersTiles.length,
                    itemBuilder: (BuildContext context, int index) => ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      child: Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection direction) {
                          final Member member = membersTiles.elementAt(index).member;
                          switch (direction) {
                            case DismissDirection.startToEnd:
                              deleteMember(member);
                              break;
                            case DismissDirection.endToStart:
                            case DismissDirection.vertical:
                            case DismissDirection.horizontal:
                            case DismissDirection.up:
                            case DismissDirection.down:
                            case DismissDirection.none:
                              throw InvalidDirectionException('error.direction'.tr());
                          }
                        },
                        confirmDismiss: (DismissDirection dismissDirection) async {
                          switch (dismissDirection) {
                            case DismissDirection.endToStart:
                              final Member member = membersTiles.elementAt(index).member;
                              editMember(member);
                              return false;
                            case DismissDirection.startToEnd:
                              return await showConfirmationDialog(context, 'delete.lower'.tr()) ?? false;
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
                  );
                }
              })));
    } else {
      return Expanded(child: RequestPlaceholder(placeholder: Text('error.request_failed'.tr())));
    }
  }

  Future<void> editMember(Member member) async {
    final dynamic edited = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return MemberDialog(
            edit: true,
            id: member.id,
            firstName: member.firstName,
            lastName: member.lastName,
            phone: member.phone,
          );
        });
    if (edited is Member) {
      final List<dynamic> result = await MemberService().editMember(edited);

      setState(() {
        getMembers();
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(PopupSnackBar().getEditedModelSnackBar(context, result[0] as bool, result[1] as int, member));
      }
    }
  }

  Future<void> deleteMember(Member member) async {
    final List<dynamic> result = await MemberService().deleteMember(member);
    if (context.mounted) {
      if (result[1] == 204) {
        setState(() {
          members.remove(member);
        });
      } else {
        getMembers();
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(PopupSnackBar().getDeletedModelSnackBar(context, result[0] as bool, result[1] as int, member));
    }
  }

  Future<void> addMember() async {
    final dynamic member = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const MemberDialog(edit: false);
        });
    if (member is Member) {
      final List<dynamic> result = await MemberService().addMember(member);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(PopupSnackBar().getNewModelSnackBar(context, result[0] as bool, result[1] as int, member));
      }
      setState(() {
        getMembers();
      });
    }
  }

  Future<void> getMembers() async {
    final List<dynamic> result = await MemberService().getMembers();
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      members = result[1] as List<Member>;
    });
  }
}
