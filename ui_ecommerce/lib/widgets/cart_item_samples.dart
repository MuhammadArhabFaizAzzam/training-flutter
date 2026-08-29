import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/widgets/app_product_image.dart';

class CartItemSamples extends StatelessWidget {
  const CartItemSamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: CartModel(),
      builder: (context, _) {
        final cart = CartModel();

        if (cart.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4C53A5).withValues(alpha: 0.1),
                          const Color(0xFF6B7CDA).withValues(alpha: 0.05),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.remove_shopping_cart_outlined,
                      size: 64,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Keranjang Masih Kosong',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1D2E),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Yuk temukan produk impianmu dan tambahkan ke keranjang!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[500], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_offer_rounded, color: Color(0xFF4C53A5), size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Gratis ongkir untuk pembelian ≥ Rp100.000',
                          style: TextStyle(
                            color: Color(0xFF4C53A5),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            // Promo Banner strip
            Container(
              margin: const EdgeInsets.fromLTRB(15, 12, 15, 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Gratis ongkir untuk pembelian ≥ Rp100.000!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'GRATIS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Item list
            for (int i = 0; i < cart.items.length; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.07),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Gambar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: AppProductImage(
                          imageUrl: cart.items[i].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          borderRadius: 0,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cart.items[i].name,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1D2E),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              cart.items[i].price,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Qty stepper
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _qtyButton(
                                        icon: Icons.remove_rounded,
                                        onTap: () => cart.decrementQuantity(i),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Text(
                                          '${cart.items[i].quantity}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Color(0xFF1A1D2E),
                                          ),
                                        ),
                                      ),
                                      _qtyButton(
                                        icon: Icons.add_rounded,
                                        onTap: () => cart.incrementQuantity(i),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Delete
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => cart.removeItem(i),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // ── Kupon Promo ──────────────────────────────
            Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: cart.couponCode != null
                      ? Colors.green.shade300
                      : const Color(0xFF4C53A5).withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: (cart.couponCode != null
                                ? Colors.green
                                : const Color(0xFF4C53A5))
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.confirmation_number_rounded,
                        color: cart.couponCode != null
                            ? Colors.green
                            : const Color(0xFF4C53A5),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cart.couponCode != null
                                ? 'Kupon: ${cart.couponCode}'
                                : 'Punya Kode Kupon?',
                            style: TextStyle(
                              color: cart.couponCode != null
                                  ? Colors.green.shade700
                                  : const Color(0xFF1A1D2E),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          if (cart.couponCode != null)
                            Text(
                              'Hemat ${(cart.discountPercent * 100).toInt()}% · ${cart.formattedDiscount}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          else
                            Text(
                              'Masukkan kode dan hemat lebih banyak!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (cart.couponCode != null)
                      TextButton(
                        onPressed: () => cart.removeCoupon(),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                        child: const Text(
                          'Hapus',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () => _showCouponDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4C53A5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          elevation: 0,
                        ),
                        child: const Text('Pakai', style: TextStyle(fontSize: 13)),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 17, color: const Color(0xFF4C53A5)),
      ),
    );
  }

  void _showCouponDialog(BuildContext context) {
    final TextEditingController couponInput = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.confirmation_number_rounded,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Masukkan Kode Kupon',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1D2E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: couponInput,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Contoh: DISKON10, PROMO50',
                  prefixIcon: const Icon(
                    Icons.discount_rounded,
                    color: Color(0xFF4C53A5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF5F7FF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Kupon Tersedia:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF1A1D2E)),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _couponChip('DISKON10', '10% off', couponInput),
                  _couponChip('PROMO50', '50% off', couponInput),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4C53A5),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        final success = CartModel().applyCoupon(couponInput.text);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success
                                  ? 'Kupon ${couponInput.text} berhasil! 🎉'
                                  : 'Kode kupon tidak valid',
                            ),
                            backgroundColor: success ? Colors.green : Colors.redAccent,
                          ),
                        );
                      },
                      child: const Text(
                        'Terapkan',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _couponChip(
    String code,
    String desc,
    TextEditingController ctrl,
  ) {
    return StatefulBuilder(builder: (context, setS) {
      return GestureDetector(
        onTap: () => ctrl.text = code,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF4C53A5).withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                code,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C53A5),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '· $desc',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
