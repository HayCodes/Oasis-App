import 'package:equatable/equatable.dart';
import 'package:oasis/common/common.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.token = '',
    this.status = FetchStatus.initial,
    this.error,
  });

  ResetPasswordState copyWith({
    String? email,
    String? password,
    String? passwordConfirmation,
    String? token,
    FetchStatus? status,
    String? error,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      token: token ?? this.token,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  final String email;
  final String password;
  final String passwordConfirmation;
  final String token;
  final String? error;
  final FetchStatus status;

  @override
  List<Object?> get props => [
    email,
    password,
    passwordConfirmation,
    token,
    status,
    error,
  ];
}
