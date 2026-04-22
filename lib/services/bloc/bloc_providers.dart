import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/profile/data/profile.repository.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.bloc.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/all_products/shop.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/app/sign_in/data/sign_in.repository.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_up/data/sign_up.repository.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
import 'package:oasis/locator.dart';

class AppBlocProviders {
  static List<BlocProvider<dynamic>> get allBlocProviders => [
    BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(sl.get<SigninRepository>()),
    ),
    BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(sl.get<SignupRepository>()),
    ),
    BlocProvider<TopProductsBloc>(
      create: (context) => TopProductsBloc(sl.get<ProductRepository>()),
    ),
    BlocProvider<AllProductsBloc>(
      create: (context) => AllProductsBloc(sl.get<ProductRepository>()),
    ),
    BlocProvider<CategoryContentBloc>(
      create: (context) => CategoryContentBloc(sl.get<CategoryRepository>()),
    ),
    BlocProvider<CategoriesBloc>(
      create: (context) => CategoriesBloc(sl.get<CategoryRepository>()),
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(sl.get<ProfileRepository>()),
    ),
    BlocProvider<ProductDetailBloc>(
      create: (context) => ProductDetailBloc(sl.get<ProductRepository>()),
    ),
  ];
}
