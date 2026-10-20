import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/item_detail_page.dart';
import 'package:ui_ecommerce/models/product_model.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';
import 'package:ui_ecommerce/widgets/app_product_image.dart';

class ItemsWidget extends StatelessWidget {
  final String searchQuery;
  final String selectedCategory;

  const ItemsWidget({
    super.key,
    this.searchQuery = '',
    this.selectedCategory = 'Semua',
  });

  @override
  Widget build(BuildContext context) {
    final cleanQuery = searchQuery.trim().toLowerCase();

    final List<ProductModel> filteredProducts =
        ProductData.products.where((product) {
      final bool matchesCategory = selectedCategory == 'Semua' ||
          product.category.toLowerCase() == selectedCategory.toLowerCase();

      if (cleanQuery.isEmpty) return matchesCategory;

      final bool matchesName = product.name.toLowerCase().contains(cleanQuery);
      final bool matchesDesc =
          product.description.toLowerCase().contains(cleanQuery);
      final bool matchesCategoryName =
          product.category.toLowerCase().contains(cleanQuery);
      final bool matchesTags =
          product.tags.any((tag) => tag.toLowerCase().contains(cleanQuery));
      final bool matchesLocation =
          product.sellerLocation.toLowerCase().contains(cleanQuery);

      return matchesCategory &&
          (matchesName ||
              matchesDesc ||
              matchesCategoryName ||
              matchesTags ||
              matchesLocation);
    }).toList();

    if (filteredProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.search_off_rounded,
                  size: 58,
                  color: Color(0xFF4C53A5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                cleanQuery.isNotEmpty
                    ? 'Tidak ditemukan untuk "$searchQuery"'
                    : 'Belum ada produk di $selectedCategory',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1D2E),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4C53A5).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Coba: "sepatu", "hoodie", "kue", "smartwatch"',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFF4C53A5)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.57,
          crossAxisSpacing: 12,
          mainAxisSpacing: 14,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = filteredProducts[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ItemDetailPage(product: product),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          )),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4C53A5).withValues(alpha: 0.07),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Gambar + Badges ──────────────────
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: AppProductImage(
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                              borderRadius: 0,
                            ),
                          ),
                        ),
                        // Gradient overlay bawah
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Color(0x33000000)],
                              ),
                            ),
                          ),
                        ),
                        // Diskon Badge
                        if (product.discountPercent > 0)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF3B30), Color(0xFFFF6B35)],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.redAccent.withValues(alpha: 0.35),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                '-${product.discountPercent}%',
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        // Tombol Favorit
                        Positioned(
                          top: 8,
                          right: 8,
                          child: _FavoriteButton(productName: product.name),
                        ),
                      ],
                    ),

                    // ── Info Produk ──────────────────────
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Official + Location
                            Row(
                              children: [
                                if (product.isOfficial)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 2,
                                    ),
                                    margin: const EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4C53A5),
                                          Color(0xFF6B7CDA),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified_rounded,
                                          color: Colors.white,
                                          size: 9,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          'RESMI',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    product.sellerLocation,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey[500],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),

                            // Nama Produk
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1D2E),
                                height: 1.3,
                              ),
                            ),
                            const Spacer(),

                            // Rating
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  '${product.rating}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1D2E),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '· ${product.soldCount}+',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 7),

                            // Harga + Tombol Keranjang
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.price,
                                        style: const TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4C53A5),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (product.discountPercent > 0)
                                        Text(
                                          CartModel.formatRupiah(
                                            (product.numericPrice * 100 /
                                                    (100 -
                                                        product
                                                            .discountPercent))
                                                .round(),
                                          ),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[400],
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor:
                                                Colors.redAccent.withValues(
                                              alpha: 0.7,
                                            ),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () {
                                    CartModel().addItem(
                                      id: product.id,
                                      name: product.name,
                                      price: product.price,
                                      image: product.image,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(
                                              Icons.check_circle_rounded,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                '${product.name} masuk keranjang 🛒',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFF4C53A5),
                                        duration: const Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4C53A5),
                                          Color(0xFF6B7CDA),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF4C53A5)
                                              .withValues(alpha: 0.35),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: filteredProducts.length,
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final String productName;

  const _FavoriteButton({required this.productName});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: FavoriteModel(),
      builder: (context, _) {
        final favModel = FavoriteModel();
        final bool isFav = favModel.isFavorite(productName);
        return GestureDetector(
          onTap: () => favModel.toggle(productName),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: isFav
                  ? Colors.red.shade50
                  : Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: isFav ? Colors.redAccent : Colors.grey[500],
              size: 17,
            ),
          ),
        );
      },
    );
  }
}
