import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';

class CartBottomNavBar extends StatefulWidget {
  const CartBottomNavBar({super.key});

  @override
  State<CartBottomNavBar> createState() => _CartBottomNavBarState();
}

class _CartBottomNavBarState extends State<CartBottomNavBar> {
  @override
  void initState() {
    super.initState();
    CartModel().addListener(_onCartChanged);
  }

  @override
  void dispose() {
    CartModel().removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartModel();
    return BottomAppBar(
      height: 140,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    color: Color(0xFF4C53A5),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  cart.formattedTotalPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (cart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Keranjang kosong!'),
                      backgroundColor: Color(0xFF4C53A5),
                    ),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Pembayaran ${cart.formattedTotalPrice} sedang diproses...',
                    ),
                    backgroundColor: const Color(0xFF4C53A5),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF4C53A5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Check Out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
