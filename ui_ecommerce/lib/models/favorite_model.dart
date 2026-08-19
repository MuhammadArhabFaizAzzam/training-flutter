import 'package:flutter/foundation.dart';

class FavoriteModel {
  static final FavoriteModel _instance = FavoriteModel._internal();
  factory FavoriteModel() => _instance;
  FavoriteModel._internal();

  final Set<String> _favoriteNames = {};
  final List<VoidCallback> _listeners = [];

  Set<String> get favoriteNames => _favoriteNames;

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  bool isFavorite(String name) {
    return _favoriteNames.contains(name);
  }

  void toggle(String name) {
    if (_favoriteNames.contains(name)) {
      _favoriteNames.remove(name);
    } else {
      _favoriteNames.add(name);
    }
    _notifyListeners();
  }
}
