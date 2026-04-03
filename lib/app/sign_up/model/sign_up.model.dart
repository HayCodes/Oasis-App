import 'dart:convert';

class SignupModel {
  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.terms,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      terms: json['terms'] as bool,
    );
  }

  factory SignupModel.fromRawJson(String str) =>
      SignupModel.fromJson(json.decode(str));

  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool terms;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'terms': terms,
    };
  }

  String toRawJson() => json.encode(toJson());
}

