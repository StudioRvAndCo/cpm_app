enum SupabaseTable {
  project('project'),
  episode('episode'),
  sequence('sequence'),
  shot('shot'),
  location('location'),
  member('member'),
  sequenceLocation('sequence_location'),
  link('link'),
  ;

  final String name;

  const SupabaseTable(this.name);
}
