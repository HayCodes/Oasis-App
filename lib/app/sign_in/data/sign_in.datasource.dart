import 'package:oasis/app/sign_in/models/sign_in.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/integrations.dart';

class SignInDataSource {
  const SignInDataSource(this.client);

  final ApiClient client;

  Future<AbstractApiResponse> signIn(SignInDto data) async {
    try {
      final res = await client.post(
        Endpoints.LOGIN,
        data: {'email': data.email, 'password': data.password},
        // headers: {"X-Client-Type": "mobile"},
      );
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
