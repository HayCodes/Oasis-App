import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:oasis/app/categories/data/categories.datasource.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/shop/data/shop.datasource.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.bloc.dart';
import 'package:oasis/app/sign_in/data/sign_in.datasource.dart';
import 'package:oasis/app/sign_in/data/sign_in.repository.dart';
import 'package:oasis/app/sign_up/data/sign_up.datasource.dart';
import 'package:oasis/app/sign_up/data/sign_up.repository.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
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
      ..registerLazySingleton(() => SessionService(sl(), sl()))
      ..registerLazySingleton<ApiClient>(
        () => ApiClient(sl(), sl(), sl(), sl()),
      )
      // datasources
      ..registerLazySingleton(() => SignInDataSource(sl()))
      ..registerLazySingleton(() => SignUpDataSource(sl()))
      ..registerLazySingleton(() => ProductDataSource(sl()))
      ..registerLazySingleton(() => CategoriesDataSource(sl()))
      // repositories
      ..registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(sl()),
      )
      ..registerLazySingleton(() => SigninRepository(sl(), sl(), sl()))
      ..registerLazySingleton(() => SignupRepository(sl(), sl(), sl()))
      ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(sl()),
      )
      // blocs
      ..registerFactory(() => ShopBloc(sl()))
      ..registerFactory(() => CategoryContentBloc(sl()))
      ..registerFactory(() => CategoriesBloc(sl()))
      ..registerFactory(() => SignUpBloc(sl()));
  }
}
