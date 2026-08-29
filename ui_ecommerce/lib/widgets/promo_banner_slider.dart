import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ui_ecommerce/models/cart_model.dart';
import 'package:ui_ecommerce/widgets/app_product_image.dart';

class PromoBannerSlider extends StatefulWidget {
  final Function(String category)? onCategorySelected;

  const PromoBannerSlider({
    super.key,
    this.onCategorySelected,
  });

  @override
  State<PromoBannerSlider> createState() => _PromoBannerSliderState();
}

class _PromoBannerSliderState extends State<PromoBannerSlider>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _beamAnimation;

  final List<Map<String, dynamic>> _banners = [
    {
      'tag': 'FLASH SALE 50% 🔥',
      'tagBg': Colors.amberAccent,
      'tagColor': Colors.black87,
      'title': 'Diskon s.d 50% Gadget & Sepatu',
      'subtitle': 'Voucher: PROMO50 • Terbatas!',
      'voucher': 'PROMO50',
      'discount': 50,
      'category': 'Sepatu',
      'glowColor': Colors.orangeAccent,
      'image':
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
      'gradient': [
        const Color(0xFF4C53A5),
        const Color(0xFF232753),
      ],
    },
    {
      'tag': 'TRENDING FASHION ✨',
      'tagBg': const Color(0xFF81E6D9),
      'tagColor': const Color(0xFF1D4044),
      'title': 'Streetwear & Outfit Casual',
      'subtitle': 'Diskon 10% Semua Baju: DISKON10',
      'voucher': 'DISKON10',
      'discount': 10,
      'category': 'Outfit',
      'glowColor': const Color(0xFF38B2AC),
      'image':
          'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=600&q=80',
      'gradient': [
        const Color(0xFF1A365D),
        const Color(0xFF2C5282),
      ],
    },
    {
      'tag': 'BEAUTY GLOW FEST 💄',
      'tagBg': const Color(0xFFFED7E2),
      'tagColor': const Color(0xFF702459),
      'title': 'Serum & Perawatan Wajah',
      'subtitle': 'Ekstrak Alami • Diskon: DISKON10',
      'voucher': 'DISKON10',
      'discount': 10,
      'category': 'Skincare',
      'glowColor': const Color(0xFFED64A6),
      'image':
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=600&q=80',
      'gradient': [
        const Color(0xFF702459),
        const Color(0xFF97266D),
      ],
    },
    {
      'tag': 'KULINER & SNACK 🍰',
      'tagBg': const Color(0xFFFEEBC8),
      'tagColor': const Color(0xFF744210),
      'title': 'Brownies Fudgy & Kopi Arabika',
      'subtitle': 'Camilan Lezat • Voucher: PROMO50',
      'voucher': 'PROMO50',
      'discount': 50,
      'category': 'Makanan',
      'glowColor': const Color(0xFFECC94B),
      'image':
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=600&q=80',
      'gradient': [
        const Color(0xFF744210),
        const Color(0xFFB7791F),
      ],
    },
    {
      'tag': 'SMART GADGET 🎧',
      'tagBg': const Color(0xFFC6F6D5),
      'tagColor': const Color(0xFF22543D),
      'title': 'Headphone ANC & Smartwatch',
      'subtitle': 'Audio Jernih • Voucher: PROMO50',
      'voucher': 'PROMO50',
      'discount': 50,
      'category': 'Elektronik',
      'glowColor': const Color(0xFF48BB78),
      'image':
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80',
      'gradient': [
        const Color(0xFF1C4532),
        const Color(0xFF2F855A),
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();

    // Inisialisasi animasi kilauan cahaya shimmer
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -1.2, end: 2.2).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOutSine,
      ),
    );

    // Animasi berkas cahaya yang menyusuri garis split diagonal
    _beamAnimation = Tween<double>(begin: -0.4, end: 1.4).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage >= _banners.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shimmerController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _claimVoucher(String voucher, String category) {
    CartModel().applyCoupon(voucher);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Voucher "$voucher" berhasil diklaim & terpasang!',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4C53A5),
        duration: const Duration(seconds: 2),
      ),
    );
    if (widget.onCategorySelected != null) {
      widget.onCategorySelected!(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 168,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              final Color glowColor = banner['glowColor'] as Color;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: banner['gradient'] as List<Color>,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: (banner['gradient'][0] as Color)
                          .withValues(alpha: 0.38),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Stack(
                    children: [
                      // 1. Halo Cahaya di Belakang Gambar
                      Positioned(
                        right: -15,
                        top: -15,
                        child: Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                glowColor.withValues(alpha: 0.45),
                                glowColor.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 2. Efek Split Slanted / Diagonal Bar di Kanan
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        width: 165,
                        child: AnimatedBuilder(
                          animation: _beamAnimation,
                          builder: (context, child) => CustomPaint(
                            painter: DiagonalSplitPainter(
                              dividerColor:
                                  Colors.white.withValues(alpha: 0.3),
                              glowColor: glowColor.withValues(alpha: 0.35),
                              beamPosition: _beamAnimation.value,
                            ),
                            child: child,
                          ),
                          child: ClipPath(
                            clipper: DiagonalSplitClipper(),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: AppProductImage(
                                    imageUrl: banner['image'] as String,
                                    fit: BoxFit.cover,
                                    borderRadius: 0,
                                  ),
                                ),
                                // Gradient shading pada gambar split
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          (banner['gradient'][0] as Color)
                                              .withValues(alpha: 0.55),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Badge diskon efek kaca (glassmorphism)
                                Positioned(
                                  top: 14,
                                  right: 14,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.18,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.45,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.local_fire_department_rounded,
                                          color: Colors.white,
                                          size: 13,
                                        ),
                                        const SizedBox(width: 3),
                                        Text(
                                          '-${banner['discount']}%',
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 3. Efek Shimmer Kilau Cahaya yang Berjalan
                      AnimatedBuilder(
                        animation: _shimmerAnimation,
                        builder: (context, child) {
                          return Positioned.fill(
                            child: FractionalTranslation(
                              translation: Offset(_shimmerAnimation.value, 0.0),
                              child: Transform.rotate(
                                angle: -0.35,
                                child: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white.withValues(alpha: 0.0),
                                        Colors.white.withValues(alpha: 0.18),
                                        Colors.white.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // 4. Informasi Konten Teks & Tombol di Kiri
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Badge Tag Promo
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: banner['tagBg'] as Color,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.15),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    banner['tag'] as String,
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      color: banner['tagColor'] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Judul Promo
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.48,
                              child: Text(
                                banner['title'] as String,
                                style: const TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black38,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Subtitle Voucher
                            Text(
                              banner['subtitle'] as String,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Tombol Klaim Voucher Interaktif
                            InkWell(
                              onTap: () => _claimVoucher(
                                banner['voucher'] as String,
                                banner['category'] as String,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5.5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.12),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Klaim Voucher',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2D3142),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.bolt_rounded,
                                      size: 14,
                                      color: banner['gradient'][0] as Color,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Indicator Dots Animasi Halus
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            final isSelected = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: isSelected ? 22 : 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4C53A5)
                    : const Color(0xFF4C53A5).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Clipper untuk memotong gambar split secara diagonal melengkung yang modern
class DiagonalSplitClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * 0.22, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
        size.width * 0.06,
        size.height * 0.5,
        size.width * 0.22,
        0,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant DiagonalSplitClipper oldClipper) => false;
}

/// Painter garis batas split dengan berkas cahaya (light beam) beranimasi
/// yang menyusuri kurva diagonal dari atas ke bawah.
class DiagonalSplitPainter extends CustomPainter {
  final Color dividerColor;
  final Color glowColor;

  /// Posisi pusat beam dalam fraksi panjang kurva (bisa < 0 atau > 1 agar
  /// beam tampak masuk dan keluar dari area banner).
  final double beamPosition;

  /// Setengah-panjang beam sebagai fraksi panjang kurva.
  static const double _halfBeam = 0.18;

  DiagonalSplitPainter({
    required this.dividerColor,
    required this.glowColor,
    required this.beamPosition,
  });

  // Titik-titik kurva quadratic bezier: start -> control -> end
  Offset _curvePoint(double t, Offset start, Offset control, Offset end) {
    final u = 1 - t;
    return Offset(
      u * u * start.dx + 2 * u * t * control.dx + t * t * end.dx,
      u * u * start.dy + 2 * u * t * control.dy + t * t * end.dy,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width * 0.22, 0);
    final control = Offset(size.width * 0.06, size.height * 0.5);
    final end = Offset(0, size.height);

    final curvePath = Path()
      ..moveTo(start.dx, start.dy)
      ..quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    // Cahaya ambient lembut di sepanjang seluruh kurva
    final paintGlow = Paint()
      ..color = glowColor
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Garis pemisah utama yang tajam
    final paintLine = Paint()
      ..color = dividerColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(curvePath, paintGlow);
    canvas.drawPath(curvePath, paintLine);

    // Berkas cahaya yang bergerak menyusuri kurva
    final t1 = (beamPosition - _halfBeam).clamp(0.0, 1.0);
    final t2 = (beamPosition + _halfBeam).clamp(0.0, 1.0);

    if (t2 - t1 > 0.01) {
      final beamStart = _curvePoint(t1, start, control, end);
      final beamEnd = _curvePoint(t2, start, control, end);

      final paintBeam = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
        ..shader = LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white.withValues(alpha: 0.0),
            Colors.white.withValues(alpha: 0.85),
            Colors.white.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromPoints(beamStart, beamEnd));

      canvas.drawLine(beamStart, beamEnd, paintBeam);

      // Titik terang di ujung depan beam
      canvas.drawCircle(
        beamEnd,
        2.2,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.95)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }
  }

  @override
  bool shouldRepaint(covariant DiagonalSplitPainter oldDelegate) =>
      oldDelegate.beamPosition != beamPosition ||
      oldDelegate.glowColor != glowColor ||
      oldDelegate.dividerColor != dividerColor;
}
