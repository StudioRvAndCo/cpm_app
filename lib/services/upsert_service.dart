import 'package:cpm/models/base_model.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/service.dart';

class UpsertService extends Service {
  Future<void> upsert(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).upsert(model.toJson());
  }
}
