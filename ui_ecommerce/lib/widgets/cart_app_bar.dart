import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Color(0xFF4C53A5),
          size: 30,
        ),
      ),
      title: const Text(
        'Cart',
        style: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4C53A5),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            size: 30,
            color: Color(0xFF4C53A5),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}