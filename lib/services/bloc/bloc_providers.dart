import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.bloc.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
import 'package:oasis/locator.dart';

class AppBlocProviders {
  static List<BlocProvider<dynamic>> get allBlocProviders => [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => sl<SignUpBloc>()),
    BlocProvider(create: (context) => sl<ShopBloc>()),
    BlocProvider(create: (context) => sl<CategoryContentBloc>()),
    BlocProvider(create: (context) => sl<CategoriesBloc>()),
  ];
}
