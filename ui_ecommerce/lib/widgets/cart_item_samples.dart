import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';

class CartItemSamples extends StatefulWidget {
  const CartItemSamples({super.key});

  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
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

    if (cart.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'Keranjang kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Tambahkan produk dari halaman utama',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < cart.items.length; i++)
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Image.asset(
                    cart.items[i].image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Color(0xFF4C53A5),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.items[i].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                        Text(
                          cart.items[i].price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          cart.removeItem(i);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                cart.decrementQuantity(i);
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 16,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '${cart.items[i].quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color(0xFF4C53A5),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cart.incrementQuantity(i);
                              },
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4C53A5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Add Coupon Code',
                  style: TextStyle(
                    color: Color(0xFF4C53A5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
