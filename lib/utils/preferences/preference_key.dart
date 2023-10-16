enum PreferenceKey {
  locale('locale'),
  theme('theme'),
  dynamicTheming('dynamic_theming', false),
  ;

  final String key;
  final bool? defaultValue;

  const PreferenceKey(this.key, [this.defaultValue]);
}
