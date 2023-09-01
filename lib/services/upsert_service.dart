import '../models/base_model.dart';
import 'config/supabase_table.dart';
import 'service.dart';

class UpsertService extends Service {
  Future<void> upsert(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).upsert(model.toJson());
  }
}
