import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

import '../../models/location/location.dart';

class SelectSequenceLocationService extends SelectService {
  SupabaseTable table = SupabaseTable.sequenceLocation;

  Future<Location> selectLocation(int? sequenceId) async {
    return await selectSingle<Location>(
      await supabase.from(table.name).select('*').eq('sequence', sequenceId),
      Location.fromJson,
    );
  }
}
