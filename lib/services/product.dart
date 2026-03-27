class Product {

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.category,
    this.isNew = false,
    this.isFavorite = false,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.tags = const [],
    this.badge,
  });
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String category;
  final bool isNew;
  final bool isFavorite;
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final String? badge;

  bool get isOnSale => originalPrice != null && originalPrice! > price;

  int get discountPercent {
    if (!isOnSale) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).round();
  }
}

final List<Product> sampleProducts = [
  Product(
    id: '1',
    name: 'Linen Oversized Blazer',
    brand: 'ARKER',
    price: 189.00,
    originalPrice: 265.00,
    imageUrl: 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=600&q=80',
    category: 'Tops',
    rating: 4.8,
    reviewCount: 124,
    tags: ['Linen', 'Oversized'],
    badge: 'SALE',
  ),
  Product(
    id: '2',
    name: 'Merino Knit Vest',
    brand: 'COS',
    price: 95.00,
    imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4b4c7b?w=600&q=80',
    category: 'Tops',
    isNew: true,
    rating: 4.6,
    reviewCount: 87,
    tags: ['Merino', 'Knit'],
  ),
  Product(
    id: '3',
    name: 'Wide-Leg Trousers',
    brand: 'TOTEME',
    price: 310.00,
    imageUrl: 'https://images.unsplash.com/photo-1551854838-212c9a5e3df6?w=600&q=80',
    category: 'Bottoms',
    isNew: true,
    rating: 4.9,
    reviewCount: 203,
    tags: ['Wide-Leg', 'Tailored'],
  ),
  Product(
    id: '4',
    name: 'Silk Slip Dress',
    brand: 'REFORMATION',
    price: 248.00,
    originalPrice: 310.00,
    imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=600&q=80',
    category: 'Dresses',
    rating: 4.7,
    reviewCount: 156,
    tags: ['Silk', 'Slip'],
    badge: 'SALE',
  ),
  Product(
    id: '5',
    name: 'Leather Tote Bag',
    brand: 'A.P.C.',
    price: 450.00,
    imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600&q=80',
    category: 'Bags',
    rating: 4.9,
    reviewCount: 341,
    tags: ['Leather', 'Tote'],
  ),
  Product(
    id: '6',
    name: 'Canvas Sneakers',
    brand: 'VEJA',
    price: 150.00,
    imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
    category: 'Shoes',
    isNew: true,
    rating: 4.6,
    reviewCount: 512,
    tags: ['Canvas', 'Sustainable'],
  ),
];

final List<String> categories = [
  'All',
  'New In',
  'Tops',
  'Bottoms',
  'Dresses',
  'Bags',
  'Shoes',
];
