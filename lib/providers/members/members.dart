import 'dart:async';
import 'dart:developer';

import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'members.g.dart';

@riverpod
class Members extends _$Members with BaseProvider {
  final _table = SupabaseTable.member;

  @override
  FutureOr<List<Member>> build() {
    get();

    return <Member>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Member>>();

    if (await CacheManager().contains(CacheKey.members)) {
      state = AsyncData<List<Member>>(
        await CacheManager().get<Member>(CacheKey.members, Member.fromJson),
      );
    }

    final List<Member> members = await selectMemberService.selectMembers();
    CacheManager().set(CacheKey.members, members);
    state = AsyncData<List<Member>>(members);
  }

  Future<bool> add(Member newMember) async {
    try {
      await insertService.insert(_table, newMember);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Member editedMember) async {
    try {
      await updateService.update(_table, editedMember);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
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
      await deleteService.delete(_table, id);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Member>>(<Member>[
      for (final Member members in state.value ?? <Member>[])
        if (members.id != id) members,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentMember extends _$CurrentMember with BaseProvider {
  @override
  FutureOr<Member> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Member member) {
    state = AsyncData<Member>(member);
  }
}
