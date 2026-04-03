import 'package:oasis/common/models/featured.image.dart';
import 'package:oasis/common/models/price.model.dart';
import 'package:oasis/common/models/product_category.model.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
    required this.popularity,
    required this.colors,
    required this.featuredImage,
    required this.category,
    required this.tags,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String? ?? '',
    price: ProductPrice.fromJson(json['price'] as Map<String, dynamic>),
    popularity: json['popularity'] as int,
    colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
    featuredImage: FeaturedImage.fromJson(
      json['featuredImage'] as Map<String, dynamic>,
    ),
    category: ProductCategory.fromJson(
      json['category'] as Map<String, dynamic>,
    ),
    tags: json['tags'] != null
        ? List<String>.from(json['tags'] as List)
        : const [],
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  final int id;
  final String name;
  final String slug;
  final ProductPrice price;
  final int popularity;
  final List<String> colors;
  final FeaturedImage featuredImage;
  final ProductCategory category;
  final List<String> tags;
  final DateTime createdAt;
}
