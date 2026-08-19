import 'package:flutter/material.dart';
import 'package:ui_ecommerce/pages/item_detail_page.dart';
import 'package:ui_ecommerce/models/product_model.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/models/favorite_model.dart';

class ItemsWidget extends StatefulWidget {
  final String searchQuery;
  final String selectedCategory;

  const ItemsWidget({
    super.key,
    this.searchQuery = '',
    this.selectedCategory = 'Semua',
  });

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
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
    List<ProductModel> filteredProducts =
        ProductData.products.where((product) {
      bool matchesSearch = widget.searchQuery.isEmpty ||
          product.name.toLowerCase().contains(widget.searchQuery.toLowerCase());
      bool matchesCategory = widget.selectedCategory == 'Semua' ||
          product.category == widget.selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    if (filteredProducts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'Produk tidak ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < filteredProducts.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '-58%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FavoriteModel().toggle(filteredProducts[i].name);
                      },
                      child: Icon(
                        FavoriteModel().isFavorite(filteredProducts[i].name)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailPage(
                          name: filteredProducts[i].name,
                          description: filteredProducts[i].description,
                          price: filteredProducts[i].price,
                          image: filteredProducts[i].image,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      filteredProducts[i].image,
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    filteredProducts[i].name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF4C53A5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    filteredProducts[i].description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      filteredProducts[i].price,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        CartModel().addItem(
                          filteredProducts[i].name,
                          filteredProducts[i].price,
                          filteredProducts[i].image,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${filteredProducts[i].name} ditambahkan ke keranjang',
                            ),
                            backgroundColor: const Color(0xFF4C53A5),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4C53A5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
