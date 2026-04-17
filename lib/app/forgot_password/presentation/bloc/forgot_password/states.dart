import 'package:equatable/equatable.dart';
import 'package:oasis/common/common.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.email = '',
    this.status = FetchStatus.initial,
    this.error,
  });

  ForgotPasswordState copyWith({
    String? email,
    FetchStatus? status,
    String? error,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  final String email;
  final String? error;
  final FetchStatus status;

  @override
  List<Object?> get props => [email, status, error];
}
