import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';

class ItemDetailPage extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  const ItemDetailPage({
    super.key,
    this.name = 'Outfit',
    this.description = 'Produk berkualitas dengan desain terbaru.',
    this.price = 'Rp 150.000',
    this.image = 'assets/images/homepages/outfit.jpg',
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    FavoriteModel().addListener(_onFavoriteChanged);
  }

  @override
  void dispose() {
    FavoriteModel().removeListener(_onFavoriteChanged);
    super.dispose();
  }

  void _onFavoriteChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF4C53A5)),
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            color: Color(0xFF4C53A5),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              FavoriteModel().isFavorite(widget.name)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: FavoriteModel().isFavorite(widget.name)
                  ? Colors.red
                  : null,
            ),
            onPressed: () {
              FavoriteModel().toggle(widget.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
            const SizedBox(height: 15),
            _buildTitleAndRating(),
            const SizedBox(height: 10),
            _buildPriceAndQuantity(),
            const SizedBox(height: 20),
            _buildDescription(),
            const SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 280,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          widget.image,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.image_not_supported,
                size: 80,
                color: Colors.grey[400],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        RatingBarIndicator(
          rating: 4.5,
          itemBuilder: (context, index) =>
              const Icon(Icons.star, color: Colors.amber),
          itemCount: 5,
          itemSize: 22,
        ),
      ],
    );
  }

  Widget _buildPriceAndQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.price,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C53A5),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (_quantity > 1) _quantity--;
                  });
                },
                child: const Icon(
                  Icons.remove,
                  size: 20,
                  color: Color(0xFF4C53A5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _quantity++;
                  });
                },
                child: const Icon(
                  Icons.add,
                  size: 20,
                  color: Color(0xFF4C53A5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deskripsi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                for (int i = 0; i < _quantity; i++) {
                  CartModel().addItem(widget.name, widget.price, widget.image);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$_quantity x ${widget.name} ditambahkan ke keranjang',
                    ),
                    backgroundColor: const Color(0xFF4C53A5),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart, size: 20),
              label: const Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4C53A5),
                side: const BorderSide(color: Color(0xFF4C53A5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                for (int i = 0; i < _quantity; i++) {
                  CartModel().addItem(widget.name, widget.price, widget.image);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Transaksi sedang diproses...'),
                    backgroundColor: Color(0xFF4C53A5),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4C53A5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Buy Now',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
