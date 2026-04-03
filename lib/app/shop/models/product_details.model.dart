import 'package:oasis/common/models/featured.image.dart';
import 'package:oasis/common/models/price.model.dart';
import 'package:oasis/common/models/product_category.model.dart';

class ProductDetail {
  const ProductDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.popularity,
    required this.colors,
    required this.rating,
    required this.featuredImage,
    required this.images,
    required this.category,
    required this.tags,
    required this.createdAt,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    price: ProductPrice.fromJson(json['price'] as Map<String, dynamic>),
    popularity: json['popularity'] as int,
    colors: List<String>.from(json['colors'] as List),
    rating: (json['rating'] as num).toDouble(),
    featuredImage: FeaturedImage.fromJson(
      json['featuredImage'] as Map<String, dynamic>,
    ),
    images: List<String>.from(json['images'] as List),
    category: ProductCategory.fromJson(
      json['category'] as Map<String, dynamic>,
    ),
    tags: List<String>.from(json['tags'] as List),
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  final int id;
  final String name;
  final String description;
  final ProductPrice price;
  final int popularity;
  final List<String> colors;
  final double rating;
  final FeaturedImage featuredImage;
  final List<String> images;
  final ProductCategory category;
  final List<String> tags;
  final DateTime createdAt;
}
