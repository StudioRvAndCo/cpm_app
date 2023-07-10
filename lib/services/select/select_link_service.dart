import 'package:cpm/models/project/link.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:cpm/utils/constants_globals.dart';

class SelectLinkService extends SelectService {
  SupabaseTable table = SupabaseTable.link;

  Future<List<Link>> selectLinks(int projectId) async {
    return await select<Link>(
      await supabase.from(table.name).select('*').eq('project', projectId),
      Link.fromJson,
    );
  }
}
