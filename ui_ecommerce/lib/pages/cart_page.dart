import 'package:flutter/material.dart';
import 'package:ui_ecommerce/widgets/cart_app_bar.dart';
import 'package:ui_ecommerce/widgets/cart_bottom_navbar.dart';
import 'package:ui_ecommerce/widgets/cart_item_samples.dart';
import 'package:ui_ecommerce/models/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: const CartAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CartItemSamples(),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}
