import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final String price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartModel {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final List<CartItem> _items = [];
  final List<VoidCallback> _listeners = [];

  List<CartItem> get items => _items;

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

  void addItem(String name, String price, String image) {
    final existingIndex = _items.indexWhere((item) => item.name == name);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(name: name, price: price, image: image));
    }
    _notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].quantity++;
    _notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      _notifyListeners();
    }
  }

  int _parsePrice(String price) {
    String cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += _parsePrice(item.price) * item.quantity;
    }
    return total;
  }

  String get formattedTotalPrice {
    String totalStr = totalPrice.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = totalStr.length - 1; i >= 0; i--) {
      buffer.write(totalStr[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  int get totalItems => _items.length;

  bool get isEmpty => _items.isEmpty;
}
