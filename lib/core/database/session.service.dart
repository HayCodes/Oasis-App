import 'package:oasis/common/common.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/core/integrations/integrations.dart';

class SessionService {
  const SessionService(this._secureStorage, this._sharedPrefs, this._apiClient);

  final SecureStorage _secureStorage;
  final SharedPrefs _sharedPrefs;
  final ApiClient _apiClient;

  Future<void> logout() async {
    try {
      await _apiClient.post(
        Endpoints.LOGOUT,
        headers: {'X-Client-Type': 'mobile'},
      );
    } catch (e) {
      rethrow;
    } finally {
      await _secureStorage.deleteAll();
      await _sharedPrefs.clear();
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(DbKeys.ACCESS_TOKEN);
    return token != null && token.isNotEmpty;
  }
}
