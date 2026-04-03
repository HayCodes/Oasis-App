import 'package:oasis/app/shop/data/shop.datasource.dart';
import 'package:oasis/app/shop/models/shop_response.models.dart';

abstract class ProductRepository {
  Future<TopProductsResponse> getTopProducts();

  Future<AllProductsResponse> getAllProducts({String? query});

  Future<ProductDetailResponse> getProductDetails(String slug);
}

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._productDataSource);

  final ProductDataSource _productDataSource;

  @override
  Future<TopProductsResponse> getTopProducts() async {
    final res = await _productDataSource.getTopProducts();
    final json = {'data': res.data as List<dynamic>};
    return TopProductsResponse.fromJson(json);
  }

  @override
  Future<AllProductsResponse> getAllProducts({String? query}) async {
    final res = await _productDataSource.getAllProducts(query: query);
    final map = res.data as Map<String, dynamic>;
    return AllProductsResponse.fromJson(map);
  }

  @override
  Future<ProductDetailResponse> getProductDetails(String slug) async {
    final res = await _productDataSource.getProductDetails(slug);
    return ProductDetailResponse.fromJson(res.data as Map<String, dynamic>);
  }
}
