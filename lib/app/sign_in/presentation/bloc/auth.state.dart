import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({this.email = '', this.password = ''});

  final String email;
  final String password;

  AuthState copyWith({String? email, String? password}) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, password];
}
