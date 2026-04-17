import 'package:oasis/app/sign_up/model/signup.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/integrations.dart';

class SignUpDataSource {
  const SignUpDataSource(this.client);

  final ApiClient client;

  Future<AbstractApiResponse> signup(SignupDto data) async {
    try {
      final res = await client.post(
        Endpoints.REGISTER,
        data: {
          'email': data.email,
          'password': data.password,
          'name': data.name,
          'password_confirmation': data.passwordConfirmation,
          'terms': data.terms,
        },
      );
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
