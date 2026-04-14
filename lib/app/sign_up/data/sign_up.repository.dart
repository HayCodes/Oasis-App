import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oasis/app/profile/models/profile.model.dart';
import 'package:oasis/app/sign_up/data/sign_up.datasource.dart';
import 'package:oasis/app/sign_up/model/signup.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/token.model.dart';
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
        final token = TokenModel.fromJson(
          data['token'] as Map<String, dynamic>,
        );

        if (user.name.isNullOrEmpty) return const Left(AppTexts.GENERIC_ERROR);

        final updatedSettings = (sharedPrefs.userSettings)
          ..firstLaunch = false
          ..userName = user.name
          ..isLoggedIn = true;

        await Future.wait([
          secureStorage.write(DbKeys.ACCESS_TOKEN, token.value),
          secureStorage.updateUserModel(user),
          sharedPrefs.updateUserSettings(updatedSettings),
        ]);

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
