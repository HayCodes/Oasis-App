import 'dart:convert';

class ForgotPasswordModel {
  ForgotPasswordModel({required this.email});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(email: json['email'] as String);
  }

  factory ForgotPasswordModel.fromRawJson(String str) =>
      ForgotPasswordModel.fromJson(json.decode(str));

  final String email;

  Map<String, dynamic> toJson() {
    return {'email': email};
  }

  String toRawJson() => json.encode(toJson());
}

class ResetPasswordModel {
  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.password_confirmation,
    required this.token,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      email: json['email'] as String,
      password: json['password'] as String,
      password_confirmation: json['password_confirmation'] as String,
      token: json['token'] as String,
    );
  }

  factory ResetPasswordModel.fromRawJson(String str) =>
      ResetPasswordModel.fromJson(json.decode(str));

  final String email;
  final String password;
  final String password_confirmation;
  final String token;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'token': token,
    };
  }

  String toRawJson() => json.encode(toJson());
}
