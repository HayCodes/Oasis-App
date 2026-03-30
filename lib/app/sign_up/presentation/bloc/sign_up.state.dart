import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.terms = false,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    bool? terms,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      terms: terms ?? this.terms,
    );
  }

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool terms;

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    passwordConfirmation,
    terms,
  ];
}
