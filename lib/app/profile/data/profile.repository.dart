import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oasis/app/profile/data/profile.datasource.dart';
import 'package:oasis/app/profile/models/profile.model.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/integrations/integrations.dart';

class ProfileRepository {
  const ProfileRepository(this._profileDataSource);

  final ProfileDataSource _profileDataSource;

  AsyncEither<UserModel> getUserProfile() async {
    try {
      final res = await _profileDataSource.getUserProfile();

      if (res.status) {
        final user = UserModel.fromJson(res.data);
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
