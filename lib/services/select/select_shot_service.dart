import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectShotService extends SelectService {
  SupabaseTable table = SupabaseTable.shot;

  Future<List<Shot>> selectShots(int sequenceId) async {
    return selectAndNumber<Shot>(
      await supabase.from(table.name).select().eq('sequence', sequenceId).order('index', ascending: true) as List,
      Shot.fromJson,
    );
  }
}
