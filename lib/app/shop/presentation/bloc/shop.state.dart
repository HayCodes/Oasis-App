import 'package:equatable/equatable.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/models/product_details.model.dart';
import 'package:oasis/common/common.dart';

class ShopState extends Equatable {
  const ShopState({
    // top products
    this.topProducts = const [],
    this.topProductsStatus = FetchStatus.initial,

    // all products
    this.allProducts = const [],
    this.allProductsStatus = FetchStatus.initial,
    this.currentPage = 1,
    this.hasReachedMax = false,

    // product detail
    this.productDetail,
    this.productDetailStatus = FetchStatus.initial,
    this.relatedProducts = const [],

    // shared
    this.errorMessage,
  });

  final List<Product> topProducts;
  final FetchStatus topProductsStatus;

  final List<Product> allProducts;
  final FetchStatus allProductsStatus;
  final int currentPage;
  final bool hasReachedMax;

  final ProductDetail? productDetail;
  final FetchStatus productDetailStatus;
  final List<Product> relatedProducts;

  final String? errorMessage;

  ShopState copyWith({
    List<Product>? topProducts,
    FetchStatus? topProductsStatus,
    List<Product>? allProducts,
    FetchStatus? allProductsStatus,
    int? currentPage,
    bool? hasReachedMax,
    ProductDetail? productDetail,
    FetchStatus? productDetailStatus,
    List<Product>? relatedProducts,
    String? errorMessage,
  }) {
    return ShopState(
      topProducts: topProducts ?? this.topProducts,
      topProductsStatus: topProductsStatus ?? this.topProductsStatus,
      allProducts: allProducts ?? this.allProducts,
      allProductsStatus: allProductsStatus ?? this.allProductsStatus,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      productDetail: productDetail ?? this.productDetail,
      productDetailStatus: productDetailStatus ?? this.productDetailStatus,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    topProducts,
    topProductsStatus,
    allProducts,
    allProductsStatus,
    currentPage,
    hasReachedMax,
    productDetail,
    productDetailStatus,
    relatedProducts,
    errorMessage,
  ];
}
