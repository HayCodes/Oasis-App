import 'package:equatable/equatable.dart';
import 'package:oasis/app/categories/models/categories.model.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/common/models/tag.model.dart';

class CategoryContent extends Equatable {
  const CategoryContent({
    required this.category,
    required this.tags,
    required this.products,
    required this.relatedProducts,
  });

  factory CategoryContent.fromJson(Map<String, dynamic> json) =>
      CategoryContent(
        category: Category.fromJson(json['category'] as Map<String, dynamic>),
        tags: (json['tags'] as List)
            .map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        products: (json['products'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        relatedProducts: (json['relatedProducts'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  final Category category;
  final List<Tag> tags;
  final List<Product> products;
  final List<Product> relatedProducts;

  @override
  List<Object> get props => [category, tags, products, relatedProducts];
}
