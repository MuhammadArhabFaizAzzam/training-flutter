import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackToHome;

  const CartAppBar({
    super.key,
    this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return ListenableBuilder(
      listenable: CartModel(),
      builder: (context, _) {
        final count = CartModel().totalItemCount;
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3A4196), Color(0xFF4C53A5)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x334C53A5),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                if (canPop) {
                  Navigator.pop(context);
                } else if (onBackToHome != null) {
                  onBackToHome!();
                } else {
                  Navigator.pushReplacementNamed(context, '/');
                }
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Keranjang Belanja',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                if (count > 0)
                  Text(
                    '$count item dipilih',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
              ],
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.more_horiz_rounded,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                onSelected: (value) {
                  if (value == 'clear') {
                    if (CartModel().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Keranjang sudah kosong'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text('Kosongkan Keranjang?'),
                        content: const Text(
                          'Semua item dalam keranjang akan dihapus.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Batal'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              CartModel().clearCart();
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Keranjang telah dikosongkan'),
                                  backgroundColor: Color(0xFF4C53A5),
                                ),
                              );
                            },
                            child: const Text('Hapus Semua'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete_sweep_rounded,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Kosongkan Keranjang',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}