import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:oasis/app/categories/data/categories.datasource.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/forgot_password/data/forgot_password.datasource.dart';
import 'package:oasis/app/forgot_password/data/forgot_password.repository.dart';
import 'package:oasis/app/profile/data/profile.datasource.dart';
import 'package:oasis/app/profile/data/profile.repository.dart';
import 'package:oasis/app/shop/data/shop.datasource.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/sign_in/data/sign_in.datasource.dart';
import 'package:oasis/app/sign_in/data/sign_in.repository.dart';
import 'package:oasis/app/sign_up/data/sign_up.datasource.dart';
import 'package:oasis/app/sign_up/data/sign_up.repository.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/core/integrations/integrations.dart';
import 'package:oasis/core/integrations/permission/permission.handler.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

final GetIt sl = GetIt.instance;

class AppManager {
  static Future<void> initializeDependencies() async {
    final sharedPrefs = await sp.SharedPreferences.getInstance();

    sl
      // core/primitives
      ..registerLazySingleton<Dio>(Dio.new)
      ..registerLazySingleton(PermissionHandler.new)
      ..registerLazySingleton(FlutterSecureStorage.new)
      ..registerLazySingleton(() => SecureStorage(sl()))
      ..registerSingleton<SharedPrefs>(SharedPrefs(sharedPrefs))
      ..registerLazySingleton<ApiClient>(() => ApiClient(sl(), sl(), sl()))
      // session
      ..registerLazySingleton(() => SessionService(sl(), sl(), sl()))
      // datasources
      ..registerLazySingleton(() => SignInDataSource(sl()))
      ..registerLazySingleton(() => SignUpDataSource(sl()))
      ..registerLazySingleton(() => ProductDataSource(sl()))
      ..registerLazySingleton(() => CategoriesDataSource(sl()))
      ..registerLazySingleton(() => ProfileDataSource(sl()))
      ..registerLazySingleton(() => ForgotPasswordDataSource(sl()))
      // repositories
      ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
      )
      ..registerLazySingleton(
        () => SigninRepository(
          sl(),
          sl(),
          sl(),
          sl<ApiClient>().tokenInterceptor,
        ),
      )
      ..registerLazySingleton(
        () => SignupRepository(
          sl(),
          sl(),
          sl(),
          sl<ApiClient>().tokenInterceptor,
        ),
      )
      ..registerLazySingleton(() => ProfileRepository(sl()))
      ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => ForgotPasswordRepository(sl()));
  }
}
