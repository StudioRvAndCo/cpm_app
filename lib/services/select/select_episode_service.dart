import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/database_function.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectEpisodeService extends SelectService {
  SupabaseTable table = SupabaseTable.episode;

  Future<List<Episode>> selectEpisodes(int projectId) async {
    final episodes = await selectAndNumber<Episode>(
      await supabase.from(table.name).select().eq('project', projectId).order('index', ascending: true) as List,
      Episode.fromJson,
    );

    for (final episode in episodes) {
      episode.shotsTotal = await supabase.rpc(
        DatabaseFunction.episodeShotsTotal.name,
        params: {DatabaseFunction.episodeShotsTotal.argument: episode.id},
      ) as int;
      episode.shotsCompleted = await supabase.rpc(
        DatabaseFunction.episodeShotsCompleted.name,
        params: {DatabaseFunction.episodeShotsCompleted.argument: episode.id},
      ) as int;
    }

    return episodes;
  }

  Future<Episode> selectFirstEpisode(int projectId) async {
    return selectSingle<Episode>(
      await supabase.from(table.name).select().eq('project', projectId).single(),
      Episode.fromJson,
      addPlaceholderNumber: true,
    );
  }
}
