import 'package:equatable/equatable.dart';
import 'package:oasis/app/categories/models/categories.model.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/tag.model.dart';

class CategoryContentState extends Equatable {
  const CategoryContentState({
    this.category,
    this.tags = const [],
    this.products = const [],
    this.relatedProducts = const [],
    this.contentStatus = FetchStatus.initial,
    this.errorMessage,
  });

  final Category? category;
  final List<Tag> tags;
  final List<Product> products;
  final List<Product> relatedProducts;
  final FetchStatus contentStatus;
  final String? errorMessage;

  CategoryContentState copyWith({
    Category? category,
    List<Tag>? tags,
    List<Product>? products,
    List<Product>? relatedProducts,
    FetchStatus? contentStatus,
    String? errorMessage,
  }) {
    return CategoryContentState(
      category: category ?? this.category,
      tags: tags ?? this.tags,
      products: products ?? this.products,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      contentStatus: contentStatus ?? this.contentStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    category,
    tags,
    products,
    relatedProducts,
    contentStatus,
    errorMessage,
  ];
}
