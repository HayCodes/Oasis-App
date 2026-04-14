import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oasis/app/profile/models/profile.model.dart';
import 'package:oasis/app/sign_in/data/sign_in.datasource.dart';
import 'package:oasis/app/sign_in/models/sign_in.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/models/token.model.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/core/integrations/integrations.dart';


class SigninRepository {
  const SigninRepository(this.dataSource, this.secureStorage, this.sharedPrefs);

  final SignInDataSource dataSource;
  final SecureStorage secureStorage;
  final SharedPrefs sharedPrefs;

  AsyncEither<UserModel> signIn(SignInDto data) async {
    try {
      final res = await dataSource.signIn(data);
      if (res.status) {
        final user = UserModel.fromJson(res.data['user']);
        final token = TokenModel.fromJson(res.data['token']);

        final updatedSettings = (sharedPrefs.userSettings)
          ..firstLaunch = false
          ..userName = user.name
          ..isLoggedIn = true;

        await Future.wait([
          secureStorage.write(DbKeys.ACCESS_TOKEN, token.value),
          secureStorage.updateUserModel(user),
          sharedPrefs.updateUserSettings(updatedSettings),
        ]);

        return Right(user);
      } else {
        return Left(res.message ?? AppTexts.GENERIC_ERROR);
      }
    } on DioException catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return const Left(AppTexts.GENERIC_ERROR);
    }
  }
}
