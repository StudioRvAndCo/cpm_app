import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/pages/members/member_dialog.dart';
import 'package:cpm/pages/members/member_tile.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/separators.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MembersPage extends ConsumerStatefulWidget {
  const MembersPage({super.key});

  @override
  ConsumerState<MembersPage> createState() => _MembersState();
}

class _MembersState extends ConsumerState<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(membersProvider).when(
        data: (List<Member> members) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: Dismissible(
                  key: UniqueKey(),
                  onDismissed: (DismissDirection direction) {
                    switch (direction) {
                      case DismissDirection.startToEnd:
                        delete(members[index]);
                      default:
                        throw Exception();
                    }
                  },
                  confirmDismiss: (DismissDirection dismissDirection) async {
                    switch (dismissDirection) {
                      case DismissDirection.endToStart:
                        edit(members[index]);
                        return false;
                      case DismissDirection.startToEnd:
                        return await showConfirmationDialog(context, 'delete.lower') ?? false;
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
                  child: MemberTile(
                    member: members[index],
                    onEdit: (Member member) {
                      edit(member);
                    },
                    onDelete: (Member member) {
                      showConfirmationDialog(context, 'delete.lower').then((bool? result) {
                        if (result ?? false) {
                          delete(member);
                        }
                      });
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Separator.divider1.divider;
            },
            itemCount: members.length,
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return requestPlaceholderError;
        },
        loading: () {
          return requestPlaceholderLoading;
        },
      ),
    );
  }

  Future<void> add() async {
    final member = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MemberDialog();
      },
    );
    if (member is Member) {
      final added = await ref.read(membersProvider.notifier).add(member);
      SnackBarManager().show(
        added ? getInfoSnackBar('snack_bars.member.added') : getErrorSnackBar('snack_bars.member.not_added'),
      );
    }
  }

  Future<void> edit(Member member) async {
    final editedMember = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MemberDialog(member: member);
      },
    );
    if (editedMember is Member) {
      final edited = await ref.read(membersProvider.notifier).edit(editedMember);
      SnackBarManager().show(
        edited ? getInfoSnackBar('snack_bars.member.edited') : getErrorSnackBar('snack_bars.member.not_edited'),
      );
    }
  }

  Future<void> delete(Member member) async {
    final deleted = await ref.read(membersProvider.notifier).delete(member.id);
    SnackBarManager().show(
      deleted ? getInfoSnackBar('snack_bars.member.deleted') : getErrorSnackBar('snack_bars.member.not_deleted'),
    );
  }
}
