import 'dart:async';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/member/member.dart';

part 'members.g.dart';

@riverpod
class Members extends _$Members with BaseProvider {
  SupabaseTable table = SupabaseTable.member;

  @override
  FutureOr<List<Member>> build() {
    get();

    return <Member>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Member>>();
    List<Member> members = await selectMemberService.selectMembers();
    state = AsyncData<List<Member>>(members);
  }

  Future<bool> add(Member newMember) async {
    try {
      await insertService.insert(table, newMember);
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Member editedMember) async {
    try {
      await updateService.update(table, editedMember);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Member>>(<Member>[
      for (final Member member in state.value ?? <Member>[])
        if (member.id != editedMember.id) member else editedMember,
    ]);

    return true;
  }

  Future<bool> delete(int id) async {
    try {
      await deleteService.delete(table, id);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Member>>(<Member>[
      for (final Member members in state.value ?? <Member>[])
        if (members.id != id) members,
    ]);

    return true;
  }
}
