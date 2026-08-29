import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/models/cart_model.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onCartTap;

  const HomeAppBar({
    super.key,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
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
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Menu Button
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _showSideMenu(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Logo & Tagline
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EcoGlobal',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'Belanja Hemat & Terpercaya',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withValues(alpha: 0.75),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Chat Badge
            _buildActionButton(
              context: context,
              icon: Icons.chat_bubble_outline_rounded,
              badgeCount: 3,
              showBadge: true,
              onTap: () => Navigator.pushNamed(context, '/list-chat'),
            ),
            const SizedBox(width: 10),
            // Cart Badge
            ListenableBuilder(
              listenable: CartModel(),
              builder: (context, _) {
                final count = CartModel().totalItemCount;
                return _buildActionButton(
                  context: context,
                  icon: Icons.shopping_cart_outlined,
                  badgeCount: count,
                  showBadge: count > 0,
                  onTap: () {
                    if (onCartTap != null) {
                      onCartTap!();
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required int badgeCount,
    required bool showBadge,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: badges.Badge(
          position: badges.BadgePosition.topEnd(top: -8, end: -8),
          showBadge: showBadge,
          badgeStyle: const badges.BadgeStyle(
            badgeColor: Color(0xFFFF6B35),
            padding: EdgeInsets.all(4),
          ),
          badgeContent: Text(
            '$badgeCount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
    );
  }

  void _showSideMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              // Header
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'EcoGlobal Store',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Toko Resmi & Terpercaya',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Selamat datang di EcoGlobal! Temukan berbagai kebutuhan outfit, kuliner lezat, skincare alami, dan gadget terbaik.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _menuTile(
                icon: Icons.local_shipping_outlined,
                title: 'Gratis Ongkir se-Indonesia',
                subtitle: 'Untuk pembelian di atas Rp 100.000',
                color: const Color(0xFF4C53A5),
              ),
              _menuTile(
                icon: Icons.verified_outlined,
                title: '100% Produk Original & Bergaransi',
                subtitle: 'Jaminan uang kembali jika tidak sesuai',
                color: Colors.green,
              ),
              _menuTile(
                icon: Icons.headset_mic_outlined,
                title: 'Customer Service 24/7',
                subtitle: 'Siap membantu kapan saja',
                color: const Color(0xFFFF6B35),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _menuTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF1A1D2E),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}