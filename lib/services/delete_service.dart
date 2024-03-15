import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/service.dart';

class DeleteService extends Service {
  Future<void> delete(SupabaseTable table, int? id) async {
    await supabase.from(table.name).delete().match({'id': id});
  }
}
