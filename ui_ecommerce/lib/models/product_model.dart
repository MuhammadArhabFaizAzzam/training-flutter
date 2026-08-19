class ProductModel {
  final String name;
  final String description;
  final String price;
  final String image;
  final String category;

  ProductModel({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });
}

class ProductData {
  static final List<ProductModel> products = [
    ProductModel(
      name: 'Outfit Casual',
      description: 'Baju trendy terbaru dengan desain modern dan nyaman dipakai sehari-hari.',
      price: 'Rp 150.000',
      image: 'assets/images/homepages/outfit.jpg',
      category: 'Outfit',
    ),
    ProductModel(
      name: 'Makanan Sehat',
      description: 'Makanan sehat organik pilihan, bebas bahan pengawet.',
      price: 'Rp 75.000',
      image: 'assets/images/homepages/makanan.jpg',
      category: 'Makanan',
    ),
    ProductModel(
      name: 'Skincare Alami',
      description: 'Perawatan kulit alami dengan bahan herbal pilihan.',
      price: 'Rp 200.000',
      image: 'assets/images/homepages/skincare.jpg',
      category: 'Skincare',
    ),
    ProductModel(
      name: 'Electronic Gadget',
      description: 'Gadget terbaru dengan teknologi canggih dan harga terjangkau.',
      price: 'Rp 1.500.000',
      image: 'assets/images/homepages/elecronic.jpg',
      category: 'Elektronik',
    ),
  ];
}
