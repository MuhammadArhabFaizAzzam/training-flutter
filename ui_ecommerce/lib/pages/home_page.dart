import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ui_ecommerce/pages/account_page.dart';
import 'package:ui_ecommerce/pages/cart_page.dart';
import 'package:ui_ecommerce/widgets/categories_widget.dart';
import 'package:ui_ecommerce/widgets/home_app_bar.dart';
import 'package:ui_ecommerce/widgets/items_widget.dart';
import 'package:ui_ecommerce/widgets/promo_banner_slider.dart';
import 'package:image_picker/image_picker.dart';

class HomePageContent extends StatefulWidget {
  final VoidCallback? onGoToCart;

  const HomePageContent({super.key, this.onGoToCart});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  final List<({String label, String query})> _categoryOptions = const [
    (label: 'Sepatu', query: 'sepatu'),
    (label: 'Tas', query: 'tas'),
    (label: 'Hoodie', query: 'hoodie'),
    (label: 'Kamera', query: 'kamera'),
    (label: 'Smartwatch', query: 'smartwatch'),
    (label: 'Serum', query: 'serum'),
    (label: 'Brownies', query: 'brownies'),
    (label: 'Kopi', query: 'kopi'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCategorySelectionDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Apa barang di gambar?',
          style: TextStyle(color: Color(0xFF1A1D2E)),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: _categoryOptions
                .map(
                  (opt) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _searchController.text = opt.query;
                          _selectedCategory = 'Semua';
                        });
                        Navigator.of(dialogCtx).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _searchController.text.trim().toLowerCase() ==
                                  opt.query.toLowerCase()
                              ? const Color(0xFF4C53A5)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _searchController.text.trim().toLowerCase() ==
                                    opt.query.toLowerCase()
                                ? Colors.transparent
                                : const Color(0xFF4C53A5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              opt.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _searchController.text.trim().toLowerCase() ==
                                        opt.query.toLowerCase()
                                    ? Colors.white
                                    : const Color(0xFF4C53A5),
                              ),
                            ),
                            if (_searchController.text.trim().toLowerCase() ==
                                opt.query.toLowerCase())
                              const Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
            },
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: HomeAppBar(onCartTap: widget.onGoToCart),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF0F2FF),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                // ── Search Bar ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4C53A5).withValues(alpha: 0.12),
                          spreadRadius: 0,
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.search_rounded,
                            size: 20,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Cari produk favorit kamu...',
                              hintStyle: TextStyle(
                                color: Color(0xFFADB5D6),
                                fontSize: 14,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              filled: false,
                            ),
                            onChanged: (value) => setState(() {}),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          IconButton(
                            icon: Icon(
                              Icons.cancel_rounded,
                              color: Colors.grey[400],
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => _searchController.clear());
                            },
                          ),
                        Container(
                          height: 54,
                          width: 54,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                            ),
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(28),
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 22,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              final XFile? picked = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 800,
                                maxHeight: 800,
                              );
                              if (picked != null) {
                                _showCategorySelectionDialog();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // ── Promo Banner ─────────────────────────────
                PromoBannerSlider(
                  onCategorySelected: (cat) {
                    setState(() => _selectedCategory = cat);
                  },
                ),
                const SizedBox(height: 24),

                // ── Section: Kategori ────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Kategori Pilihan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1D2E),
                        ),
                      ),
                      const Spacer(),
                      if (_selectedCategory != 'Semua' ||
                          _searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = 'Semua';
                              _searchController.clear();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C53A5).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Reset',
                              style: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CategoriesWidget(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() => _selectedCategory = category);
                  },
                ),
                const SizedBox(height: 22),

                // ── Section: Produk ──────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFF6B35), Color(0xFFFF9A62)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _searchController.text.isNotEmpty
                              ? 'Hasil: "${_searchController.text}"'
                              : (_selectedCategory == 'Semua'
                                  ? 'Rekomendasi Produk'
                                  : '📦 $_selectedCategory'),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1D2E),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        ItemsWidget(
          searchQuery: _searchController.text,
          selectedCategory: _selectedCategory,
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 30),
        ),
      ],
    );
  }

}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: [
          HomePageContent(onGoToCart: () => _onTabTapped(1)),
          CartPage(onBackToHome: () => _onTabTapped(0)),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        height: 65,
        color: const Color(0xFF4C53A5),
        buttonBackgroundColor: const Color(0xFF3A4196),
        animationDuration: const Duration(milliseconds: 350),
        animationCurve: Curves.easeInOutCubic,
        items: const [
          Icon(Icons.home_rounded, size: 28, color: Colors.white),
          Icon(Icons.shopping_cart_rounded, size: 28, color: Colors.white),
          Icon(Icons.person_rounded, size: 28, color: Colors.white),
        ],
        index: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
