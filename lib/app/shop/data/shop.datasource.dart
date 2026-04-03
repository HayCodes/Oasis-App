import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/integrations.dart';

class ProductDataSource {
  const ProductDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> getTopProducts() async {
    try {
      final res = await client.get(Endpoints.PRODUCTS_TOP);
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<AbstractApiResponse> getAllProducts({String? query}) async {
    try {
      final res = await client.get(Endpoints.productsAll(query));
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<AbstractApiResponse> getProductDetails(String slug) async {
    try {
      final res = await client.get(Endpoints.productDetails(slug));
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
