import 'config/supabase_table.dart';
import 'service.dart';

class DeleteService extends Service {
  Future<void> delete(SupabaseTable table, int? id) async {
    await supabase.from(table.name).delete().match({'id': id});
  }
}
