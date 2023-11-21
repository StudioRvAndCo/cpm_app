import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/database_function.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectSequenceService extends SelectService {
  SupabaseTable table = SupabaseTable.sequence;

  Future<List<Sequence>> selectSequences(int? episodeId) async {
    final List<Sequence> sequences = await selectAndNumber<Sequence>(
      await supabase
          .from(table.name)
          .select('*, location: location(*)')
          .eq('episode', episodeId)
          .order('index', ascending: true) as List,
      Sequence.fromJson,
    );

    for (final sequence in sequences) {
      sequence.shotsTotal = await supabase.rpc(
        DatabaseFunction.sequenceShotsTotal.name,
        params: {DatabaseFunction.sequenceShotsTotal.argument: sequence.id},
      ) as int;
      sequence.shotsCompleted = await supabase.rpc(
        DatabaseFunction.sequenceShotsCompleted.name,
        params: {DatabaseFunction.sequenceShotsCompleted.argument: sequence.id},
      ) as int;
    }

    return sequences;
  }
}
