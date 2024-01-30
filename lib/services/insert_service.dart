import 'package:cpm/models/base_model.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/service.dart';

class InsertService extends Service {
  Future<void> insert(SupabaseTable table, dynamic models) async {
    final data = models is List
        ? models.map((model) {
            return (model as BaseModel).toJson();
          }).toList()
        : (models as BaseModel).toJson();
    await supabase.from(table.name).insert(data);
  }

  Future<Model> insertAndReturn<Model extends BaseModel>(
    SupabaseTable table,
    BaseModel model,
    Model Function(Map<String, dynamic>) constructor,
  ) async {
    final List data = await supabase.from(table.name).insert(model.toJson()).select('*');

    return constructor(data[0] as Map<String, dynamic>);
  }
}
