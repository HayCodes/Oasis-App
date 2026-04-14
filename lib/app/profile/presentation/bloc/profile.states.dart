import 'package:equatable/equatable.dart';
import 'package:oasis/common/common.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.email = '',
    this.name = '',
    this.avatar = '',
    this.emailVerified = false,
    this.status = FetchStatus.initial,
    this.error,
  });
  final String email;
  final String name;
  final String avatar;
  final bool emailVerified;
  final FetchStatus? status;
  final String? error;

  ProfileState copyWith({
    String? email,
    FetchStatus? status,
    String? error,
    String? name,
    String? avatar,
    bool? emailVerified,
  }) {
    return ProfileState(
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      emailVerified: emailVerified ?? this.emailVerified,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    email,
    name,
    avatar,
    emailVerified,
    status,
    error,
  ];
}
