import '../models/base_model.dart';
import 'config/supabase_table.dart';
import 'service.dart';

class InsertService extends Service {
  Future<void> insert(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).insert(model.toJson());
  }

  Future<Model> insertAndReturn<Model extends BaseModel>(
    SupabaseTable table,
    BaseModel model,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    final data = await supabase.from(table.name).insert(model.toJson()).select();

    return constructor(data[0]);
  }
}
