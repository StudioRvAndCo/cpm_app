import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/invalid_direction.dart';
import '../models/member/member.dart';
import '../providers/members.dart';
import '../utils/constants_globals.dart';
import '../widgets/custom_snack_bars.dart';
import '../widgets/dialogs/confirm_dialog.dart';
import '../widgets/dialogs/member_dialog.dart';
import '../widgets/tiles/member_tile.dart';

class Members extends ConsumerStatefulWidget {
  const Members({super.key});

  @override
  ConsumerState<Members> createState() => _MembersState();
}

class _MembersState extends ConsumerState<Members> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
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
                          break;
                        case DismissDirection.endToStart:
                        case DismissDirection.vertical:
                        case DismissDirection.horizontal:
                        case DismissDirection.up:
                        case DismissDirection.down:
                        case DismissDirection.none:
                          throw InvalidDirection('error.direction'.tr());
                      }
                    },
                    confirmDismiss: (DismissDirection dismissDirection) async {
                      switch (dismissDirection) {
                        case DismissDirection.endToStart:
                          edit(members[index]);
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
                    child: MemberTile(
                      member: members[index],
                      onEdit: (Member member) {
                        edit(member);
                      },
                      onDelete: (Member member) {
                        showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) {
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
                return divider;
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
      ),
    );
  }

  Future<void> add() async {
    final member = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MemberDialog(edit: false);
      },
    );
    if (member is Member) {
      final Map<String, dynamic> result = await ref.read(membersProvider.notifier).add(member);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.member.added'.tr() : 'snack_bars.member.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }

  Future<void> edit(Member member) async {
    final editedMember = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MemberDialog(
          edit: true,
          id: member.id,
          firstName: member.firstName,
          lastName: member.lastName,
          phone: member.phone,
        );
      },
    );
    if (editedMember is Member) {
      final Map<String, dynamic> result = await ref.read(membersProvider.notifier).edit(editedMember);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.member.edited'.tr() : 'snack_bars.member.not_edited'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }

  Future<void> delete(Member member) async {
    final Map<String, dynamic> result = await ref.read(membersProvider.notifier).delete(member.id);
    if (context.mounted) {
      final bool succeeded = result['succeeded'] as bool;
      final int code = result['code'] as int;
      final String message = succeeded ? 'snack_bars.member.deleted'.tr() : 'snack_bars.member.not_deleted'.tr();
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
    }
  }
}
