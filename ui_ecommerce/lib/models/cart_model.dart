import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String price;
  final int numericPrice;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.numericPrice,
    required this.image,
    this.quantity = 1,
  });
}

class CartModel extends ChangeNotifier {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;

  CartModel._internal() {
    // Menambahkan item awal sebagai contoh interaktif
    _items.add(
      CartItem(
        id: '3',
        name: 'Kue Bolu Lembut Spesial',
        price: 'Rp 45.000',
        numericPrice: 45000,
        image: 'assets/images/cart/kue-bolu.jpg',
        quantity: 1,
      ),
    );
    _items.add(
      CartItem(
        id: '4',
        name: 'Brownies Fudgy Cokelat',
        price: 'Rp 60.000',
        numericPrice: 60000,
        image: 'assets/images/cart/kue-brownies.jpg',
        quantity: 2,
      ),
    );
  }

  final List<CartItem> _items = [];
  String? _couponCode;
  double _discountPercent = 0.0;

  List<CartItem> get items => List.unmodifiable(_items);
  String? get couponCode => _couponCode;
  double get discountPercent => _discountPercent;

  static int parsePrice(String price) {
    String cleaned = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  static String formatRupiah(int amount) {
    String numStr = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = numStr.length - 1; i >= 0; i--) {
      buffer.write(numStr[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return 'Rp ${buffer.toString().split('').reversed.join()}';
  }

  void addItem({
    required String name,
    required String price,
    required String image,
    String? id,
    int quantity = 1,
  }) {
    final existingIndex = _items.indexWhere((item) => item.name == name);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          price: price,
          numericPrice: parsePrice(price),
          image: image,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  bool applyCoupon(String code) {
    final normalized = code.trim().toUpperCase();
    if (normalized == 'DISKON10' || normalized == 'HEMAT10') {
      _couponCode = normalized;
      _discountPercent = 0.10;
      notifyListeners();
      return true;
    } else if (normalized == 'PROMO50' || normalized == 'SUPER50') {
      _couponCode = normalized;
      _discountPercent = 0.50;
      notifyListeners();
      return true;
    } else if (normalized == 'DISKON20' || normalized == 'HEMAT20') {
      _couponCode = normalized;
      _discountPercent = 0.20;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removeCoupon() {
    _couponCode = null;
    _discountPercent = 0.0;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _couponCode = null;
    _discountPercent = 0.0;
    notifyListeners();
  }

  int get subtotalPrice {
    int total = 0;
    for (var item in _items) {
      total += item.numericPrice * item.quantity;
    }
    return total;
  }

  int get discountAmount {
    return (subtotalPrice * _discountPercent).round();
  }

  int get finalTotalPrice {
    int total = subtotalPrice - discountAmount;
    return total < 0 ? 0 : total;
  }

  String get formattedSubtotal => formatRupiah(subtotalPrice);
  String get formattedDiscount => formatRupiah(discountAmount);
  String get formattedTotalPrice => formatRupiah(finalTotalPrice);

  int get totalItemCount {
    int count = 0;
    for (var item in _items) {
      count += item.quantity;
    }
    return count;
  }

  int get totalUniqueItems => _items.length;

  bool get isEmpty => _items.isEmpty;
}

