import 'package:oasis/app/shop/data/shop.datasource.dart';
import 'package:oasis/app/shop/models/shop_response.models.dart';
import 'package:oasis/common/common.dart';

abstract class ProductRepository {
  // Future<TopProductsResponse> getTopProducts();
  // Future<AllProductsResponse> getAllProducts({String? query});
  // Future<ProductDetailResponse> getProductDetails(String slug);
  AsyncEither<TopProductsResponse> getTopProducts();
  AsyncEither<AllProductsResponse> getAllProducts({String? query});
  AsyncEither<ProductDetailResponse> getProductDetails(String slug);
}

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._productDataSource);
  final ProductDataSource _productDataSource;

  @override
  // Future<TopProductsResponse> getTopProducts() async {
  //   final res = await _productDataSource.getTopProducts();
  //   final json = {'data': res.data as List<dynamic>};
  //   return TopProductsResponse.fromJson(json);
  // }
  AsyncEither<TopProductsResponse> getTopProducts() async {
    final res = await _productDataSource.getTopProducts();
    return res.map(TopProductsResponse.fromJson);
  }

  @override
  // Future<AllProductsResponse> getAllProducts({String? query}) async {
  //   final res = await _productDataSource.getAllProducts(query: query);
  //   final map = res.data as Map<String, dynamic>;
  //   return AllProductsResponse.fromJson(map);
  // }
  AsyncEither<AllProductsResponse> getAllProducts({String? query}) async {
    final res = await _productDataSource.getTopProducts();
    return res.map(AllProductsResponse.fromJson);
  }

  @override
  // Future<ProductDetailResponse> getProductDetails(String slug) async {
  //   final res = await _productDataSource.getProductDetails(slug);
  //   return ProductDetailResponse.fromJson(res.data as Map<String, dynamic>);
  // }
  AsyncEither<ProductDetailResponse> getProductDetails(String slug) async {
    final res = await _productDataSource.getProductDetails(slug);
    return res.map(ProductDetailResponse.fromJson);
  }
}
