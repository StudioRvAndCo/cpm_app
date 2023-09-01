enum ConfigKey {
  supabaseUrl('supabase', 'url'),
  supabaseAnonKey('supabase', 'anon_key'),
  ;

  final String parent;
  final String name;

  const ConfigKey(this.parent, this.name);
}
