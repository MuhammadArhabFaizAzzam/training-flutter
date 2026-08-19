import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoriesWidget({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'Semua',
      'Outfit',
      'Makanan',
      'Skincare',
      'Elektronik',
    ];

    final List<String> categoriesImages = [
      'assets/images/homepages/outfit.jpg',
      'assets/images/homepages/outfit.jpg',
      'assets/images/homepages/makanan.jpg',
      'assets/images/homepages/skincare.jpg',
      'assets/images/homepages/elecronic.jpg',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < categories.length; i++)
            GestureDetector(
              onTap: () {
                onCategorySelected(categories[i]);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: selectedCategory == categories[i]
                      ? const Color(0xFF4C53A5)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (i > 0)
                      Image.asset(
                        categoriesImages[i],
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: selectedCategory == categories[i]
                                  ? Colors.white.withValues(alpha: 0.3)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.category,
                              color: selectedCategory == categories[i]
                                  ? Colors.white
                                  : Colors.grey,
                              size: 25,
                            ),
                          );
                        },
                      ),
                    if (i > 0) const SizedBox(width: 10),
                    Text(
                      categories[i],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: selectedCategory == categories[i]
                            ? Colors.white
                            : const Color(0xFF4C53A5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
