import '../models/base_model.dart';
import 'config/supabase_table.dart';
import 'service.dart';

class UpdateService extends Service {
  Future<void> update(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).update(model.toJson()).match({'id': model.id});
  }

  Future<void> updateWhere(SupabaseTable table, BaseModel model, String field, String value) async {
    await supabase.from(table.name).update(model.toJson()).match({field: value});
  }
}
