import 'package:equatable/equatable.dart';
import 'package:oasis/common/common.dart';

class AuthState extends Equatable {
  const AuthState({
    this.email = '',
    this.password = '',
    this.status = FetchStatus.initial,
    this.error,
  });

  final String email;
  final String password;
  final FetchStatus? status;
  final String? error;

  AuthState copyWith({
    String? email,
    String? password,
    FetchStatus? status,
    String? error,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [email, password, status, error];
}
