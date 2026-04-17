import 'package:oasis/app/forgot_password/models/reset_password.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/abstract.api.model.dart';
import 'package:oasis/core/integrations/integrations.dart';

class ForgotPasswordDataSource {
  const ForgotPasswordDataSource(this.client);
  final ApiClient client;

  Future<AbstractApiResponse> forgotPassword(String email) async {
    try {
      final res = await client.post(
        Endpoints.FORGOT_PASSWORD,
        data: {'email': email},
      );
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }

  Future<AbstractApiResponse> resetPassword(ResetPasswordDto data) async {
    try {
      final res = await client.post(
        Endpoints.RESET_PASSWORD,
        data: {
          'email': data.email,
          'password': data.password,
          'password_confirmation': data.password_confirmation,
          'token': data.token,
        },
      );
      return handleResponse(res);
    } catch (e) {
      rethrow;
    }
  }
}
