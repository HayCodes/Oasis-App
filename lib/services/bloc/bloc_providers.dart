import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/profile/presentation/bloc/profile.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/all_products/shop.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
import 'package:oasis/locator.dart';

class AppBlocProviders {
  static List<BlocProvider<dynamic>> get allBlocProviders => [
    BlocProvider(create: (context) => sl<AuthBloc>()),
    BlocProvider(create: (context) => sl<SignUpBloc>()),
    BlocProvider(create: (context) => sl<TopProductsBloc>()),
    BlocProvider(create: (context) => sl<AllProductsBloc>()),
    BlocProvider(create: (context) => sl<CategoryContentBloc>()),
    BlocProvider(create: (context) => sl<CategoriesBloc>()),
    BlocProvider(create: (context) => sl<ProfileBloc>()),
  ];
}
