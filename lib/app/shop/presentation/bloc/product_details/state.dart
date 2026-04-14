import 'package:equatable/equatable.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/models/product_details.model.dart';
import 'package:oasis/common/common.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.product,
    this.relatedProducts = const [],
    this.productDetailsStatus = FetchStatus.initial,
    this.errorMessage,
  });

  final ProductDetail? product;
  final List<Product> relatedProducts;
  final FetchStatus productDetailsStatus;
  final String? errorMessage;

  ProductDetailState copyWith({
    ProductDetail? product,
    List<Product>? relatedProducts,
    FetchStatus? productDetailsStatus,
    String? errorMessage,
  }) => ProductDetailState(
    product: product ?? this.product,
    relatedProducts: relatedProducts ?? this.relatedProducts,
    productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    product,
    relatedProducts,
    productDetailsStatus,
    errorMessage,
  ];
}
