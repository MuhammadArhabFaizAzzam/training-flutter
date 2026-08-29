class ProductModel {
  final String id;
  final String name;
  final String description;
  final String price;
  final int numericPrice;
  final String image;
  final String category;
  final double rating;
  final int discountPercent;
  final int soldCount;
  final List<String> tags;
  final String sellerLocation;
  final bool isOfficial;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.numericPrice,
    required this.image,
    required this.category,
    this.rating = 4.8,
    this.discountPercent = 20,
    this.soldCount = 120,
    this.tags = const [],
    this.sellerLocation = 'Jakarta Pusat',
    this.isOfficial = true,
  });
}

class ProductData {
  static final List<ProductModel> products = [
    // ============ SEPATU ============
    const ProductModel(
      id: '1',
      name: 'Sepatu Sneaker Nike Air Max Sport',
      description:
          'Sepatu sneaker premium dengan teknologi bantalan udara Air Max yang memberikan kenyamanan maksimal saat berlari maupun beraktivitas kasual seharian.',
      price: 'Rp 450.000',
      numericPrice: 450000,
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=600&q=80',
      category: 'Sepatu',
      rating: 4.9,
      discountPercent: 35,
      soldCount: 1420,
      tags: ['sepatu', 'sneakers', 'nike', 'running', 'sport', 'olahraga', 'pria', 'merah', 'air max'],
      sellerLocation: 'Jakarta Barat',
      isOfficial: true,
    ),
    const ProductModel(
      id: '2',
      name: 'Sepatu Casual Sneakers White Edition',
      description:
          'Sneakers putih klasik dengan sol karet empuk anti-selip dan siluet ramping yang mudah dipadukan dengan gaya fashion apa pun.',
      price: 'Rp 320.000',
      numericPrice: 320000,
      image:
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=600&q=80',
      category: 'Sepatu',
      rating: 4.8,
      discountPercent: 20,
      soldCount: 890,
      tags: ['sepatu', 'sneakers', 'putih', 'white', 'casual', 'adidas', 'fashion', 'wanita', 'pria'],
      sellerLocation: 'Bandung',
      isOfficial: true,
    ),

    // ============ OUTFIT & FASHION ============
    const ProductModel(
      id: '3',
      name: 'Hoodie Oversize Streetwear Essential',
      description:
          'Hoodie tebal berbahan katun fleece 330gsm dengan potongan oversized modern, kantong kangaroo praktis, dan jahitan presisi tahan lama.',
      price: 'Rp 185.000',
      numericPrice: 185000,
      image:
          'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&w=600&q=80',
      category: 'Outfit',
      rating: 4.9,
      discountPercent: 25,
      soldCount: 2300,
      tags: ['hoodie', 'jaket', 'sweater', 'outfit', 'baju', 'streetwear', 'oversize', 'hitam', 'pria', 'wanita'],
      sellerLocation: 'Jakarta Selatan',
      isOfficial: true,
    ),
    const ProductModel(
      id: '4',
      name: 'Kemeja Flannel Tartan Long Sleeve',
      description:
          'Kemeja flannel motif kotak-kotak klasik dengan bahan lembut dan hangat, cocok dipakai sebagai kemeja kasual maupun luaran (outerwear).',
      price: 'Rp 135.000',
      numericPrice: 135000,
      image:
          'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?auto=format&fit=crop&w=600&q=80',
      category: 'Outfit',
      rating: 4.7,
      discountPercent: 15,
      soldCount: 670,
      tags: ['kemeja', 'flannel', 'baju', 'outfit', 'pria', 'atasan', 'casual', 'tartan'],
      sellerLocation: 'Surabaya',
      isOfficial: false,
    ),

    // ============ ELEKTRONIK & GADGET ============
    const ProductModel(
      id: '5',
      name: 'Smartwatch Pro AMOLED Display',
      description:
          'Jam tangan pintar dengan layar AMOLED jernih, sensor detak jantung 24/7, pemantau tidur, notifikasi pesan instan, dan daya tahan baterai hingga 14 hari.',
      price: 'Rp 550.000',
      numericPrice: 550000,
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
      category: 'Elektronik',
      rating: 4.9,
      discountPercent: 40,
      soldCount: 950,
      tags: ['smartwatch', 'jam', 'jam tangan', 'elektronik', 'gadget', 'watch', 'apple', 'fitness', 'bluetooth'],
      sellerLocation: 'Jakarta Pusat',
      isOfficial: true,
    ),
    const ProductModel(
      id: '6',
      name: 'Wireless Headphone Active Noise Cancelling',
      description:
          'Headphone nirkabel dengan teknologi ANC peredam kebisingan aktif, suara bass mendalam, mikrofon jernih, dan baterai tahan hingga 40 jam.',
      price: 'Rp 780.000',
      numericPrice: 780000,
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=600&q=80',
      category: 'Elektronik',
      rating: 5.0,
      discountPercent: 30,
      soldCount: 620,
      tags: ['headphone', 'headset', 'audio', 'earphone', 'elektronik', 'sony', 'wireless', 'bluetooth', 'musik'],
      sellerLocation: 'Jakarta Utara',
      isOfficial: true,
    ),
    const ProductModel(
      id: '7',
      name: 'Kamera Mirrorless 4K Vlogging Pro',
      description:
          'Kamera digital mirrorless dengan kemampuan rekaman video 4K 60fps, autofokus mata super cepat, dan sensor CMOS resolusi tinggi untuk konten kreator.',
      price: 'Rp 4.500.000',
      numericPrice: 4500000,
      image:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=600&q=80',
      category: 'Elektronik',
      rating: 4.8,
      discountPercent: 18,
      soldCount: 110,
      tags: ['kamera', 'camera', 'mirrorless', 'foto', 'fotografi', 'vlog', 'elektronik', 'gadget', '4k', 'canon', 'sony'],
      sellerLocation: 'Tangerang',
      isOfficial: true,
    ),

    // ============ SKINCARE & BEAUTY ============
    const ProductModel(
      id: '8',
      name: 'Brightening Glow Face Serum 30ml',
      description:
          'Serum pencerah wajah dengan kandungan Niacinamide 10%, Vitamin C murni, dan Hyaluronic Acid untuk memudarkan noda hitam serta mencerahkan kulit secara merata.',
      price: 'Rp 125.000',
      numericPrice: 125000,
      image:
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=600&q=80',
      category: 'Skincare',
      rating: 4.9,
      discountPercent: 20,
      soldCount: 3100,
      tags: ['skincare', 'serum', 'glow', 'wajah', 'beauty', 'kosmetik', 'kecantikan', 'glowing', 'brightening'],
      sellerLocation: 'Jakarta Selatan',
      isOfficial: true,
    ),
    const ProductModel(
      id: '9',
      name: 'Hydrating Barrier Moisture Gel Cream',
      description:
          'Pelembab gel ringan yang cepat meresap dengan formula 5X Ceramide dan Centella Asiatica untuk menenangkan kulit sensitif dan mengunci hidrasi 24 jam.',
      price: 'Rp 95.000',
      numericPrice: 95000,
      image:
          'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&w=600&q=80',
      category: 'Skincare',
      rating: 4.8,
      discountPercent: 15,
      soldCount: 1850,
      tags: ['skincare', 'moisturizer', 'pelembab', 'cream', 'gel', 'beauty', 'ceramide', 'glowing'],
      sellerLocation: 'Yogyakarta',
      isOfficial: true,
    ),

    // ============ MAKANAN & MINUMAN ============
    const ProductModel(
      id: '10',
      name: 'Brownies Fudgy Dark Chocolate Almond',
      description:
          'Brownies panggang dengan lelehan cokelat Belgia pekat, tekstur lembut fudgy lumer di mulut, serta taburan kacang almond renyah berlimpah.',
      price: 'Rp 65.000',
      numericPrice: 65000,
      image:
          'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?auto=format&fit=crop&w=600&q=80',
      category: 'Makanan',
      rating: 5.0,
      discountPercent: 10,
      soldCount: 1600,
      tags: ['brownies', 'cokelat', 'cake', 'kue', 'makanan', 'manis', 'dessert', 'almond', 'kuliner'],
      sellerLocation: 'Bandung',
      isOfficial: false,
    ),
    const ProductModel(
      id: '11',
      name: 'Kue Bolu Pandan Keju Super Lembut',
      description:
          'Bolu pandan wangi asli daun suji dengan tekstur selembut sutra, dilapisi butter cream istimewa dan parutan keju cheddar melimpah.',
      price: 'Rp 48.000',
      numericPrice: 48000,
      image:
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=600&q=80',
      category: 'Makanan',
      rating: 4.8,
      discountPercent: 15,
      soldCount: 840,
      tags: ['bolu', 'kue', 'pandan', 'keju', 'cake', 'makanan', 'roti', 'kuliner', 'cemilan'],
      sellerLocation: 'Jakarta Timur',
      isOfficial: false,
    ),
    const ProductModel(
      id: '12',
      name: 'Biji Kopi Arabika Gayo Specialty 250g',
      description:
          'Kopi single origin Arabika Gayo Aceh dengan proses full wash, menghasilkan aroma floral harum dan cita rasa fruity manis dengan aftertaste bersih.',
      price: 'Rp 85.000',
      numericPrice: 85000,
      image:
          'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?auto=format&fit=crop&w=600&q=80',
      category: 'Makanan',
      rating: 4.9,
      discountPercent: 10,
      soldCount: 920,
      tags: ['kopi', 'coffee', 'arabika', 'gayo', 'minuman', 'makanan', 'espresso', 'cafe', 'biji kopi'],
      sellerLocation: 'Aceh',
      isOfficial: true,
    ),

    // ============ AKSESORIS ============
    const ProductModel(
      id: '13',
      name: 'Tas Ransel Laptop Waterproof Urban',
      description:
          'Tas punggung backpack ergonomis dengan kompartemen laptop 15.6 inch busa tebal, bahan anti-air, port USB charging eksternal, dan desain minimalis elegan.',
      price: 'Rp 210.000',
      numericPrice: 210000,
      image:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80',
      category: 'Aksesoris',
      rating: 4.8,
      discountPercent: 30,
      soldCount: 1100,
      tags: ['tas', 'ransel', 'backpack', 'laptop', 'aksesoris', 'waterproof', 'pria', 'kuliah', 'kerja'],
      sellerLocation: 'Jakarta Barat',
      isOfficial: true,
    ),
    const ProductModel(
      id: '14',
      name: 'Kacamata Hitam Polarized UV400 Classic',
      description:
          'Kacamata gaya polarized dengan perlindungan UV400 anti silau matahari, bingkai logam ringan kokoh, dan desain vintage abadi.',
      price: 'Rp 98.000',
      numericPrice: 98000,
      image:
          'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=600&q=80',
      category: 'Aksesoris',
      rating: 4.7,
      discountPercent: 20,
      soldCount: 750,
      tags: ['kacamata', 'sunglasses', 'aksesoris', 'polarized', 'fashion', 'vintage', 'pria', 'wanita'],
      sellerLocation: 'Jakarta Utara',
      isOfficial: false,
    ),
  ];
}

