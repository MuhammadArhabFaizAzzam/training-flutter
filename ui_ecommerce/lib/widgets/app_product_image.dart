import 'package:flutter/material.dart';

class AppProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double borderRadius;

  const AppProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetwork = imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    Widget imageWidget;
    if (isNetwork) {
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          final expectedBytes = loadingProgress.expectedTotalBytes;
          final cumulative = loadingProgress.cumulativeBytesLoaded;
          final progress = expectedBytes != null ? cumulative / expectedBytes : null;
          return Container(
            width: width,
            height: height,
            color: const Color(0xFFF0F1F8),
            child: Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 2,
                  color: const Color(0xFF4C53A5),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      );
    } else {
      imageWidget = Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      );
    }

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFF0F1F8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.shopping_bag_outlined,
              size: 32,
              color: Color(0xFF757CC6),
            ),
            SizedBox(height: 4),
            Text(
              'EcoGlobal',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF757CC6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

