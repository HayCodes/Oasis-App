import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oasis/app/profile/models/profile.model.dart';
import 'package:oasis/app/sign_up/data/sign_up.datasource.dart';
import 'package:oasis/app/sign_up/model/signup.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/core/integrations/integrations.dart';

class SignupRepository {
  const SignupRepository(this.dataSource, this.secureStorage, this.sharedPrefs);

  final SignUpDataSource dataSource;
  final SecureStorage secureStorage;
  final SharedPrefs sharedPrefs;

  AsyncEither<String> signup(SignupDto data) async {
    try {
      final res = await dataSource.signup(data);

      if (res.status) {
        final data = res.data as Map<String, dynamic>;
        final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        final token =
            (data['token'] as Map<String, dynamic>)['value'] as String?;

        if (user.name.isNullOrEmpty) return const Left(AppTexts.GENERIC_ERROR);
        if (token == null) return const Left(AppTexts.GENERIC_ERROR);

        await secureStorage.write('auth_token', token);
        final saved = await secureStorage.read('auth_token');
        debugPrint('auth_token saved: $saved');
        await sharedPrefs.setString('name', user.name);

        return Right(user.name ?? "");
      }

      return Left(res.message ?? AppTexts.GENERIC_ERROR);
    } on DioException catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return const Left(AppTexts.GENERIC_ERROR);
    }
  }
}
