
import 'dart:convert';

import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/user.settings.model.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

class SharedPrefs {
  const SharedPrefs(this._sharedPrefs);

  final sp.SharedPreferences _sharedPrefs;

  Future<bool> setBool(String key, bool value) async =>
      _sharedPrefs.setBool(key, value);

  Future<bool> setString(String key, String? value) async =>
      _sharedPrefs.setString(key, value!);

  Future<String?> getString(String key) async => _sharedPrefs.getString(key);

  Future<bool> setStringList(String key, List<String> value) async =>
      _sharedPrefs.setStringList(key, value);

  Future<List<String>?> getStringList(String key) async =>
      _sharedPrefs.getStringList(key);

  Future<bool?> getBool(String key) async => _sharedPrefs.getBool(key);

  Future<bool> dispose(String key) async => _sharedPrefs.remove(key);

  Future<bool> clear() async {
    final keys = _sharedPrefs.getKeys();
    for (final key in keys) {
      if (key != DbKeys.USER_SETTINGS) {
        await dispose(key);
      }
    }

    final userSettings = this.userSettings
      ..isLoggedIn = false
      ..userName = null;

    await updateUserSettings(userSettings);

    return true;
  }

  Future<bool> clearAll() async => _sharedPrefs.clear();

  Future<void> updateUserSettings(UserSettingsModel settings) async {
    final json = jsonEncode(settings.toJson());
    await _sharedPrefs.setString(DbKeys.USER_SETTINGS, json);
  }

  UserSettingsModel get userSettings {
    final json = _sharedPrefs.getString(DbKeys.USER_SETTINGS);
    if (json != null) {
      final Map<String, dynamic> decoded = jsonDecode(json);
      return UserSettingsModel.fromJson(decoded);
    } else {
      return UserSettingsModel.empty;
    }
  }
}
