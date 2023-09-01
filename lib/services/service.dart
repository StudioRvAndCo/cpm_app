import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Service {
  final supabase = Supabase.instance.client;
}
