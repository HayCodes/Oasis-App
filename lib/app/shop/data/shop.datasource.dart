import 'package:dartz/dartz.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/integrations/integrations.dart';

class ProductDataSource {
  const ProductDataSource(this.client);
  final ApiClient client;

  AsyncEither<Map<String, dynamic>> getTopProducts() async {
    try {
      final res = await client.get(Endpoints.PRODUCTS_TOP);
      return right(res.data as Map<String, dynamic>);
    } catch (e) {
      return left(e.toString());
    }
  }

  AsyncEither<Map<String, dynamic>> getAllProducts({String? query}) async {
    try {
      final res = await client.get(Endpoints.productsAll(query));
      return right(res.data as Map<String, dynamic>);
    } catch (e) {
      return left(e.toString());
    }
  }

  AsyncEither<Map<String, dynamic>> getProductDetails(String slug) async {
    try {
      final res = await client.get(Endpoints.productDetails(slug));
      return right(res.data as Map<String, dynamic>);
    } catch (e) {
      return left(e.toString());
    }
  }
}
