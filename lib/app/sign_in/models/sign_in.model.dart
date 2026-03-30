import 'dart:convert';

class SignInModel {
  SignInModel({required this.email, this.password});

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  factory SignInModel.fromRawJson(String str) =>
      SignInModel.fromJson(json.decode(str));

  final String email;
  final String? password;

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  String toRawJson() => json.encode(toJson());
}
