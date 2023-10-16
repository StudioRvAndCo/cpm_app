import 'package:cpm/models/location/location.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectSequenceLocationService extends SelectService {
  SupabaseTable table = SupabaseTable.sequenceLocation;

  Future<Location> selectLocation(int? sequenceId) async {
    return selectSingle<Location>(
      await supabase.from(table.name).select('*').eq('sequence', sequenceId) as Map<String, dynamic>,
      Location.fromJson,
    );
  }
}
