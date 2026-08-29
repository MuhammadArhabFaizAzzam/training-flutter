import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/product_model.dart';

class FavoriteModel extends ChangeNotifier {
  static final FavoriteModel _instance = FavoriteModel._internal();
  factory FavoriteModel() => _instance;
  FavoriteModel._internal() {
    // Tambah default contoh favorit (harus sesuai nama produk di ProductData)
    _favoriteNames.add('Brownies Fudgy Dark Chocolate Almond');
    _favoriteNames.add('Hoodie Oversize Streetwear Essential');
  }

  final Set<String> _favoriteNames = {};

  Set<String> get favoriteNames => Set.unmodifiable(_favoriteNames);

  bool isFavorite(String name) {
    return _favoriteNames.contains(name);
  }

  void toggle(String name) {
    if (_favoriteNames.contains(name)) {
      _favoriteNames.remove(name);
    } else {
      _favoriteNames.add(name);
    }
    notifyListeners();
  }

  void removeFavorite(String name) {
    if (_favoriteNames.remove(name)) {
      notifyListeners();
    }
  }

  void clearFavorites() {
    _favoriteNames.clear();
    notifyListeners();
  }

  int get count => _favoriteNames.length;

  List<ProductModel> get favoriteProducts {
    return ProductData.products
        .where((product) => _favoriteNames.contains(product.name))
        .toList();
  }
}

