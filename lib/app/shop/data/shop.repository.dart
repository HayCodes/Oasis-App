import 'package:oasis/app/shop/data/shop.datasource.dart';
import 'package:oasis/app/shop/models/shop_response.models.dart';
import 'package:oasis/common/common.dart';

abstract class ProductRepository {
  AsyncEither<TopProductsResponse> getTopProducts();
  AsyncEither<AllProductsResponse> getAllProducts({String? query});
  AsyncEither<ProductDetailResponse> getProductDetails(String slug);
}

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._productDataSource);
  final ProductDataSource _productDataSource;

  @override
  AsyncEither<TopProductsResponse> getTopProducts() async {
    final res = await _productDataSource.getTopProducts();
    return res.map(TopProductsResponse.fromJson);
  }

  @override
  AsyncEither<AllProductsResponse> getAllProducts({String? query}) async {
    final res = await _productDataSource.getTopProducts();
    return res.map(AllProductsResponse.fromJson);
  }

  @override
  AsyncEither<ProductDetailResponse> getProductDetails(String slug) async {
    final res = await _productDataSource.getProductDetails(slug);
    return res.map(ProductDetailResponse.fromJson);
  }
}
