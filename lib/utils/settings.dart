import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO(mael): rework favorites with riverpod

class MyFavorites {
  static const String favoritesKey = 'favorites_key';

  Future<void> setFavorites(List<String> ids) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(favoritesKey, ids);
  }

  Future<List<String>> getFavorites() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? result = sharedPreferences.getStringList(favoritesKey);

    return result ?? <String>[];
  }
}

class ModelFav extends ChangeNotifier {
  late List<String> _favoriteProjects;
  late MyFavorites _savedFavorites;

  List<String> get favoriteProjects => _favoriteProjects;

  set favoriteProjects(List<String> favorites) {
    _favoriteProjects = favorites;
    _savedFavorites.setFavorites(favorites);
    notifyListeners();
  }

  ModelFav() {
    _favoriteProjects = <String>[];
    _savedFavorites = MyFavorites();
    getFavorites();
  }

  Future<void> getFavorites() async {
    _favoriteProjects = await _savedFavorites.getFavorites();
    notifyListeners();
  }
}
