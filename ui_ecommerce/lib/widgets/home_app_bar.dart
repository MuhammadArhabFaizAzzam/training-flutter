import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ui_ecommerce/pages/cart_page.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(
            Icons.sort,
            size: 30,
            color: Color(0xFF4C53A5),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'EcoGlobal',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          const Spacer(), // ← Tambahkan const
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: const Text(
              '9',
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {
                // Pastikan route 'ListChat' sudah didaftarkan di main.dart
                Navigator.pushNamed(context, '/list-chat');
              },
              child: const Icon(
                Icons.message_sharp,
                size: 32,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          const SizedBox(width: 15),
          badges.Badge(
            badgeStyle: const badges.BadgeStyle(
              badgeColor: Colors.red,
              padding: EdgeInsets.all(7),
            ),
            badgeContent: const Text(
              '4',
              style: TextStyle(color: Colors.white),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}