import 'package:equatable/equatable.dart';
import 'package:oasis/common/common.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.terms = false,
    this.status = FetchStatus.initial,
    this.error
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    bool? terms,
    FetchStatus? status,
    String? error,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      terms: terms ?? this.terms,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool terms;
  final String? error;
  final FetchStatus status;

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    passwordConfirmation,
    terms,
    status,
    error
  ];
}
