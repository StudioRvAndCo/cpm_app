import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectLinkService extends SelectService {
  SupabaseTable table = SupabaseTable.link;

  Future<List<Link>> selectLinks(int projectId) async {
    return select<Link>(
      await supabase.from(table.name).select().eq('project', projectId).order('index', ascending: true) as List,
      Link.fromJson,
    );
  }
}
