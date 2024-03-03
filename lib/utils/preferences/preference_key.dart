enum PreferenceKey {
  locale(),
  theme(),
  dynamicTheming(false),
  ;

  final Object? defaultValue;

  const PreferenceKey([this.defaultValue]);
}
