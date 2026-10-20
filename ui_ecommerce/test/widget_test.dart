import 'package:flutter_test/flutter_test.dart';

import 'package:ui_ecommerce/main.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';

void main() {
  testWidgets('App membuka halaman login saat pertama dijalankan', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Masuk ke Akun'), findsOneWidget);
    expect(find.text('Masuk Sekarang'), findsOneWidget);
  });

  test('CartModel menghitung subtotal & format rupiah dengan benar', () {
    final cart = CartModel();
    cart.clearCart();

    cart.addItem(name: 'Produk Uji', price: 'Rp 100.000', image: '');
    cart.addItem(name: 'Produk Uji 2', price: 'Rp 50.000', image: '');

    expect(cart.totalItemCount, 2);
    expect(cart.subtotalPrice, 150000);
    expect(cart.formattedSubtotal, 'Rp 150.000');
  });

  test('Kupon PROMO50 memberikan diskon 50%', () {
    final cart = CartModel();
    cart.clearCart();

    cart.addItem(name: 'Produk Uji', price: 'Rp 200.000', image: '');
    expect(cart.applyCoupon('promo50'), isTrue);
    expect(cart.discountPercent, 0.5);
    expect(cart.finalTotalPrice, 100000);

    cart.removeCoupon();
    expect(cart.couponCode, isNull);
  });

  test('Kupon tidak valid ditolak', () {
    final cart = CartModel();
    expect(cart.applyCoupon('KODENGASAL'), isFalse);
  });

  test('Favorit default konsisten dengan daftar produk', () {
    final fav = FavoriteModel();
    expect(fav.favoriteProducts.length, fav.count);
  });
}
