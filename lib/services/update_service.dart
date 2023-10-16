import 'package:cpm/models/base_model.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/service.dart';

class UpdateService extends Service {
  Future<void> update(SupabaseTable table, BaseModel model) async {
    await supabase.from(table.name).update(model.toJson()).match({'id': model.id});
  }

  Future<void> updateWhere(SupabaseTable table, BaseModel model, String field, String value) async {
    await supabase.from(table.name).update(model.toJson()).match({field: value});
  }
}
