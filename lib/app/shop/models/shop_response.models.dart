import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/models/product_details.model.dart';
import 'package:oasis/common/models/product_pagination.model.dart';

class TopProductsResponse {
  const TopProductsResponse({required this.data});

  factory TopProductsResponse.fromJson(Map<String, dynamic> json) =>
      TopProductsResponse(
        data: (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  final List<Product> data;
}

// For getAllProducts — paginated
class AllProductsResponse {
  const AllProductsResponse({
    required this.data,
    required this.meta,
    required this.links,
  });

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) =>
      AllProductsResponse(
        data: (json['data'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: PaginationMeta.fromJson(json['meta'] as Map<String, dynamic>),
        links: PaginationLinks.fromJson(json['links'] as Map<String, dynamic>),
      );
  final List<Product> data;
  final PaginationMeta meta;
  final PaginationLinks links;
}

// getProductDetails
class ProductDetailResponse {
  const ProductDetailResponse({
    required this.product,
    required this.relatedProducts,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailResponse(
        product: ProductDetail.fromJson(
          json['product'] as Map<String, dynamic>,
        ),
        relatedProducts: (json['relatedProducts'] as List)
            .map((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  final ProductDetail product;
  final List<Product> relatedProducts;
}
