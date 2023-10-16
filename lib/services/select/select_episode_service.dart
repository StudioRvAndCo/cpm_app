import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectEpisodeService extends SelectService {
  SupabaseTable table = SupabaseTable.episode;

  Future<List<Episode>> selectEpisodes(int? projectId) async {
    return selectAndNumber<Episode>(
      await supabase.from(table.name).select('*').eq('project', projectId) as List,
      Episode.fromJson,
    );
  }

  Future<Episode> selectFirstEpisode(int? projectId) async {
    return selectSingle<Episode>(
      await supabase.from(table.name).select('*').eq('project', projectId).single() as Map<String, dynamic>,
      Episode.fromJson,
      addPlaceholderNumber: true,
    );
  }
}
