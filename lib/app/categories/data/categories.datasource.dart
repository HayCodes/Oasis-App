import 'package:oasis/common/constants.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/http/api.client.dart';

class CategoriesDataSource {
  const CategoriesDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> getAllCategories({String? query}) async {
    try {
      final res = await client.get(Endpoints.categoryAll(query));
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<AbstractApiResponse> getCategoryContent(String slug) async {
    try {
      final res = await client.get(Endpoints.categoryContent(slug));
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
