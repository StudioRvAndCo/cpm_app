import 'package:cpm/models/member/member.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectMemberService extends SelectService {
  SupabaseTable table = SupabaseTable.member;

  Future<List<Member>> selectMembers() async {
    return select<Member>(
      await supabase.from(table.name).select('*').order('first_name', ascending: true) as List,
      Member.fromJson,
    );
  }
}
