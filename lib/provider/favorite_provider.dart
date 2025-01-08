import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<int> _favoriteIds = [];

  List<int> get favoriteIds => _favoriteIds;


  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('favorites')?.map((e) => int.parse(e)).toList() ?? [];
    notifyListeners();
  }


  Future<void> toggleFavorite(int itemId) async {
    if (_favoriteIds.contains(itemId)) {
      _favoriteIds.remove(itemId);
    } else {
      _favoriteIds.add(itemId);
    }
    notifyListeners();
    _saveFavorites();
  }


  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favoriteIds.map((e) => e.toString()).toList());
  }


  bool isFavorite(int itemId) {
    return _favoriteIds.contains(itemId);
  }
}
