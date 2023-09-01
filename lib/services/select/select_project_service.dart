import 'package:cpm/models/project/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectProjectService extends SelectService {
  SupabaseTable table = SupabaseTable.project;

  Future<List<Project>> selectProjects() async {
    return await select<Project>(
      await supabase.from(table.name).select('*'),
      Project.fromJson,
    );
  }

  Future<List<Link>> selectLinks(int id) async {
    return await select<Link>(
      await supabase.from(SupabaseTable.link.name).select('*').eq('project', id),
      Link.fromJson,
    );
  }
}
