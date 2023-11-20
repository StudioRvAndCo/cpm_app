import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/sequence_location/sequence_location.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/database_function.dart';
import 'package:cpm/services/select/select_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectSequenceService extends SelectService {
  SupabaseTable table = SupabaseTable.sequence;

  Future<List<Sequence>> selectSequences(int? episodeId) async {
    final List<Sequence> sequences = await selectAndNumber<Sequence>(
      await supabase.from(table.name).select('*').eq('episode', episodeId).order('index', ascending: true) as List,
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

      try {
        final sequenceLocationData =
            await supabase.from(SupabaseTable.sequenceLocation.name).select('*').eq('sequence', sequence.id).single();
        final SequenceLocation sequenceLocation = await selectSingle<SequenceLocation>(
          sequenceLocationData as Map<String, dynamic>,
          SequenceLocation.fromJson,
        );
        sequence.location = await selectSingle<Location>(
          await supabase.from(SupabaseTable.location.name).select('*').eq('id', sequenceLocation.location).single()
              as Map<String, dynamic>,
          Location.fromJson,
        );
      } on PostgrestException catch (_) {}
    }

    return sequences;
  }
}
