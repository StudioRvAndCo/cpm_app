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

  Future<void> add(Member newMember) async {
    await insertService.insert(table, newMember);
    await get(); // Get the members in order to get the new member's ID
  }

  Future<void> edit(Member editedMember) async {
    await updateService.update(table, editedMember);
    state = AsyncData<List<Member>>(<Member>[
      for (final Member member in state.value ?? <Member>[])
        if (member.id != editedMember.id) member else editedMember,
    ]);
  }

  Future<void> delete(int id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Member>>(<Member>[
      for (final Member members in state.value ?? <Member>[])
        if (members.id != id) members,
    ]);
  }
}
