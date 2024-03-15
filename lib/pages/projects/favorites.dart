import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  late List<String> favorites;
  late final SharedPreferences _sharedPreferences;
  late final String _favoritesKey = 'favorites';

  static final Favorites _instance = Favorites._internal();

  factory Favorites() {
    return _instance;
  }

  Favorites._internal();

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    get();
  }

  void get() {
    favorites = _sharedPreferences.getStringList(_favoritesKey) ?? [];
  }

  void add(String id) {
    favorites.add(id);
    _sharedPreferences.setStringList(_favoritesKey, favorites);
  }

  void remove(String id) {
    favorites.remove(id);
    _sharedPreferences.setStringList(_favoritesKey, favorites);
  }

  bool isFavorite(String id) {
    return favorites.contains(id);
  }
}
