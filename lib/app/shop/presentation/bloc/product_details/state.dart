import 'package:equatable/equatable.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/models/product_details.model.dart';
import 'package:oasis/common/common.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState({
    this.relatedProducts = const [],
    this.productDetailsStatus = FetchStatus.initial,
    this.errorMessage,
    this.productsMap = const {}
  });

  final Map<String, ProductDetail> productsMap;
  final List<Product> relatedProducts;
  final FetchStatus productDetailsStatus;
  final String? errorMessage;

  ProductDetailState copyWith({
    List<Product>? relatedProducts,
    FetchStatus? productDetailsStatus,
    String? errorMessage,
    Map<String, ProductDetail>? productsMap,
  }) => ProductDetailState(
    relatedProducts: relatedProducts ?? this.relatedProducts,
    productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
    errorMessage: errorMessage ?? this.errorMessage,
    productsMap: productsMap ?? this.productsMap,
  );

  ProductDetail? getProduct(String id) {
    return productsMap[id];
  }

  @override
  List<Object?> get props => [
    relatedProducts,
    productDetailsStatus,
    errorMessage,
    productsMap
  ];
}
