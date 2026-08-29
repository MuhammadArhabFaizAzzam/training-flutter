import 'package:flutter/material.dart';
import 'package:ui_ecommerce/widgets/cart_app_bar.dart';
import 'package:ui_ecommerce/widgets/cart_bottom_navbar.dart';
import 'package:ui_ecommerce/widgets/cart_item_samples.dart';

class CartPage extends StatelessWidget {
  final VoidCallback? onBackToHome;

  const CartPage({
    super.key,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: CartAppBar(onBackToHome: onBackToHome),
      body: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            CartItemSamples(),
            SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}

