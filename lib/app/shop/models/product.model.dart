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
    slug: json['slug'] as String? ?? json['id'].toString(),
    price: ProductPrice.fromJson(json['price'] as Map<String, dynamic>),
    popularity: json['popularity'] as int,
    colors: List<String>.from(json['colors'] ?? []),
    featuredImage: FeaturedImage.fromJson(
      json['featuredImage'] as Map<String, dynamic>,
    ),
    category: json['category'] != null
        ? ProductCategory.fromJson(json['category'] as Map<String, dynamic>)
        : ProductCategory.empty(),
    tags: List<String>.from(json['tags'] ?? []),
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
