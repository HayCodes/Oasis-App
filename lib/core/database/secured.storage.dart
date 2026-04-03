import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oasis/app/profile/models/profile.model.dart';
import 'package:oasis/common/common.dart';

class SecureStorage {
  SecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> write(String key, String? value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      return;
    }
  }

  Future<String?> read(String key) async {
    try {
      final readData = await _storage.read(key: key);
      return readData;
    } catch (e) {
      try {
        await _storage.delete(key: key);
      } catch (e) {
        return null;
      }
      return null;
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      return;
    }
  }

  Future<void> updateUserModel(UserModel user) async {
    final json = jsonEncode(user.toJson());
    await write(DbKeys.USER_MODEL, json);
  }

  Future<UserModel?> get userModel async {
    final json = await read(DbKeys.USER_MODEL);
    if (json != null) {
      final Map<String, dynamic> decoded = jsonDecode(json);
      return UserModel.fromJson(decoded);
    } else {
      return null;
    }
  }
}
