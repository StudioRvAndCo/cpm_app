import 'package:cpm/models/location/location.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/services/select/select_service.dart';

class SelectLocationService extends SelectService {
  SupabaseTable table = SupabaseTable.location;

  Future<List<Location>> selectLocations() async {
    return select<Location>(
      await supabase.from(table.name).select('*').order('name', ascending: true) as List,
      Location.fromJson,
    );
  }
}
