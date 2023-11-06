import 'package:cpm/models/base_model.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/insert_service.dart';
import 'package:cpm/services/service.dart';

class UpdateService extends Service {
  Future<void> update(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).update(model.toJson()).match({'id': model.id});
  }

  Future<void> updateOrInsert(SupabaseTable table, BaseModel model, String field, String value) async {
    final sequences = await supabase.from(table.name).select('*').eq(field, value) as List;

    if (sequences.isEmpty) {
      await InsertService().insert(table, model);
    } else {
      await supabase.from(table.name).update(model.toJson()).match({field: value});
    }
  }
}
