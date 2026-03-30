import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';

class AppBlocProviders {
  static List<BlocProvider<dynamic>> get allBlocProviders => [
    BlocProvider(create: (context) => AuthBloc()),
    BlocProvider(create: (context) => SignUpBloc())
  ];
}