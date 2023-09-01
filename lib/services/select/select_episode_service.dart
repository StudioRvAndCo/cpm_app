import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

import '../../models/episode/episode.dart';

class SelectEpisodeService extends SelectService {
  SupabaseTable table = SupabaseTable.episode;

  Future<List<Episode>> selectEpisodes(int? projectId) async {
    return await selectAndNumber<Episode>(
      await supabase.from(table.name).select('*').eq('project', projectId),
      Episode.fromJson,
    );
  }

  Future<Episode> selectFirstEpisode(int? projectId) async {
    return await selectSingle<Episode>(
      await supabase.from(table.name).select('*').eq('project', projectId).single(),
      Episode.fromJson,
      addPlaceholderNumber: true,
    );
  }
}
