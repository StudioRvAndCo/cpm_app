import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/database_function.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectProjectService extends SelectService {
  SupabaseTable table = SupabaseTable.project;

  Future<List<Project>> selectProjects() async {
    final projects = await select<Project>(
      await supabase.from(table.name).select('*'),
      Project.fromJson,
    );

    for (final project in projects) {
      project.shotsTotal = await supabase.rpc(
        DatabaseFunction.projectShotsTotal.name,
        params: {DatabaseFunction.projectShotsTotal.argument: project.id},
      ) as int;
      project.shotsCompleted = await supabase.rpc(
        DatabaseFunction.projectShotsCompleted.name,
        params: {DatabaseFunction.projectShotsCompleted.argument: project.id},
      ) as int;
    }

    return projects;
  }

  Future<List<Link>> selectLinks(int id) async {
    return select<Link>(
      await supabase.from(SupabaseTable.link.name).select('*').eq('project', id) as List,
      Link.fromJson,
    );
  }
}
