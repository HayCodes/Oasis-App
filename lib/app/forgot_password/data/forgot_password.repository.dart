import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oasis/app/forgot_password/data/forgot_password.datasource.dart';
import 'package:oasis/app/forgot_password/models/reset_password.dto.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/integrations/integrations.dart';

class ForgotPasswordRepository {
  const ForgotPasswordRepository(this.dataSource);

  final ForgotPasswordDataSource dataSource;

  AsyncEither<String> forgotPassword(String email) async {
    try {
      final res = await dataSource.forgotPassword(email);
      if (res.status) {
        return Right(res.message ?? '');
      } else {
        return Left(res.message ?? AppTexts.GENERIC_ERROR);
      }
    } on DioException catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return const Left(AppTexts.GENERIC_ERROR);
    }
  }

  AsyncEither<String> resetPassword(ResetPasswordDto data) async {
    try {
      final res = await dataSource.resetPassword(data);

      if (res.status) {
        return Right(res.message ?? '');
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
