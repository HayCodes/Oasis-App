import 'package:oasis/core/database/database.dart';

class SessionService {
  const SessionService(this._secureStorage, this._sharedPrefs);

  final SecureStorage _secureStorage;
  final SharedPrefs _sharedPrefs;

  Future<void> logout() async {
    await _secureStorage.deleteAll();
    await _sharedPrefs.clear();
  }
}