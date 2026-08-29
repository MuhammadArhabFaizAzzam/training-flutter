import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';
import 'package:ui_ecommerce/models/product_model.dart';
import 'package:ui_ecommerce/widgets/app_product_image.dart';

class ItemDetailPage extends StatefulWidget {
  final ProductModel product;

  const ItemDetailPage({
    super.key,
    required this.product,
  });

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int _quantity = 1;
  int _selectedVariantIndex = 0;

  final List<String> _variants = ['Varian Standar', 'Premium Edition', 'Special Black', 'Limited Pack'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF4C53A5),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            color: Color(0xFF4C53A5),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          ListenableBuilder(
            listenable: FavoriteModel(),
            builder: (context, _) {
              final isFav = FavoriteModel().isFavorite(widget.product.name);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.redAccent : const Color(0xFF4C53A5),
                ),
                onPressed: () {
                  FavoriteModel().toggle(widget.product.name);
                },
              );
            },
          ),
          ListenableBuilder(
            listenable: CartModel(),
            builder: (context, _) {
              final count = CartModel().totalItemCount;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 2, end: 2),
                  showBadge: count > 0,
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.redAccent,
                    padding: EdgeInsets.all(5),
                  ),
                  badgeContent: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFF4C53A5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(),
            const SizedBox(height: 16),
            _buildTitleAndRating(),
            const SizedBox(height: 14),
            _buildPriceAndQuantity(),
            const SizedBox(height: 16),
            _buildVariantSelector(),
            const SizedBox(height: 16),
            _buildDescription(),
            const SizedBox(height: 16),
            _buildProductHighlights(),
            const SizedBox(height: 16),
            _buildStoreInfo(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomStickyBar(),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppProductImage(
              imageUrl: widget.product.image,
              fit: BoxFit.cover,
              borderRadius: 20,
            ),
            if (widget.product.discountPercent > 0)
              Positioned(
                top: 14,
                left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF3B30), Color(0xFFFF6B35)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Diskon ${widget.product.discountPercent}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndRating() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.product.isOfficial) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4C53A5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'OFFICIAL STORE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              const Text(
                'Ready Stock',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingBarIndicator(
                rating: widget.product.rating,
                itemBuilder: (context, index) =>
                    const Icon(Icons.star_rounded, color: Colors.amber),
                itemCount: 5,
                itemSize: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${widget.product.rating} · ${widget.product.soldCount}+ Terjual',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndQuantity() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Harga Produk',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    widget.product.price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                  if (widget.product.discountPercent > 0) ...[
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        CartModel.formatRupiah(
                          (widget.product.numericPrice * 100 /
                                  (100 - widget.product.discountPercent))
                              .round(),
                        ),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough,
                          decorationColor:
                              Colors.redAccent.withValues(alpha: 0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
              if (widget.product.discountPercent > 0)
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Hemat ${CartModel.formatRupiah((widget.product.numericPrice * widget.product.discountPercent / 100).round())}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
          // Stepper Kuantitas
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4C53A5).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    if (_quantity > 1) {
                      setState(() => _quantity--);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                    setState(() => _quantity++);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantSelector() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih Varian / Warna',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_variants.length, (index) {
              final isSelected = _selectedVariantIndex == index;
              return ChoiceChip(
                label: Text(
                  _variants[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.white : const Color(0xFF4C53A5),
                  ),
                ),
                selected: isSelected,
                selectedColor: const Color(0xFF4C53A5),
                backgroundColor: const Color(0xFF4C53A5).withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected
                        ? const Color(0xFF4C53A5)
                        : Colors.grey.withValues(alpha: 0.2),
                  ),
                ),
                onSelected: (selected) {
                  setState(() {
                    _selectedVariantIndex = index;
                  });
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi & Spesifikasi Produk',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductHighlights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildHighlightItem(Icons.verified_user_outlined, 'Garansi 100% Asli'),
          _buildHighlightItem(Icons.local_shipping_outlined, 'Bebas Ongkir'),
          _buildHighlightItem(Icons.replay_rounded, 'Retur 7 Hari'),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF4C53A5), size: 24),
        const SizedBox(height: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF4C53A5),
            radius: 20,
            child: Icon(Icons.storefront, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EcoGlobal Official Store',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  '${widget.product.sellerLocation} · Rating ${widget.product.rating}',
                  style: const TextStyle(fontSize: 11.5, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomStickyBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      CartModel().addItem(
                        id: widget.product.id,
                        name: widget.product.name,
                        price: widget.product.price,
                        image: widget.product.image,
                        quantity: _quantity,
                      );
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$_quantity x ${widget.product.name} (${_variants[_selectedVariantIndex]}) masuk ke keranjang',
                          ),
                        backgroundColor: const Color(0xFF4C53A5),
                        action: SnackBarAction(
                          label: 'Lihat Keranjang',
                          textColor: Colors.amberAccent,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: const Text(
                    '+ Keranjang',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF4C53A5),
                    side: const BorderSide(color: Color(0xFF4C53A5), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      CartModel().addItem(
                        id: widget.product.id,
                        name: widget.product.name,
                        price: widget.product.price,
                        image: widget.product.image,
                        quantity: _quantity,
                      );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C53A5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    ),
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


