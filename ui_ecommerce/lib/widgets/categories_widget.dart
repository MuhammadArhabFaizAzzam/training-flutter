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
    final List<Map<String, dynamic>> categoryItems = [
      {
        'title': 'Semua',
        'icon': Icons.grid_view_rounded,
        'color': const Color(0xFF4C53A5),
      },
      {
        'title': 'Sepatu',
        'icon': Icons.roller_skating_outlined,
        'color': const Color(0xFFE65100),
      },
      {
        'title': 'Outfit',
        'icon': Icons.checkroom_rounded,
        'color': const Color(0xFF1565C0),
      },
      {
        'title': 'Elektronik',
        'icon': Icons.devices_other_rounded,
        'color': const Color(0xFF2E7D32),
      },
      {
        'title': 'Skincare',
        'icon': Icons.face_retouching_natural_rounded,
        'color': const Color(0xFFC2185B),
      },
      {
        'title': 'Makanan',
        'icon': Icons.cake_outlined,
        'color': const Color(0xFF795548),
      },
      {
        'title': 'Aksesoris',
        'icon': Icons.watch_outlined,
        'color': const Color(0xFF6A1B9A),
      },
    ];

    return SizedBox(
      height: 48,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          final item = categoryItems[index];
          final String title = item['title'] as String;
          final bool isSelected = selectedCategory == title;
          final IconData iconData = item['icon'] as IconData;
          final Color categoryColor = item['color'] as Color;

          return GestureDetector(
            onTap: () => onCategorySelected(title),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          categoryColor,
                          categoryColor.withValues(alpha: 0.75),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.grey.withValues(alpha: 0.15),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? categoryColor.withValues(alpha: 0.35)
                        : Colors.black.withValues(alpha: 0.04),
                    blurRadius: isSelected ? 10 : 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconData,
                    size: 17,
                    color: isSelected ? Colors.white : categoryColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                      color: isSelected ? Colors.white : const Color(0xFF1A1D2E),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
