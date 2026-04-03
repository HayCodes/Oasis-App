import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/http/api.client.dart';

class ProfileDataSource {
  const ProfileDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> getUserProfile() async {
    try {
      final res = await client.get(Endpoints.ME);
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
