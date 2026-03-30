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

class UserModel {
  UserModel({
    String? name,
    String? email,
    String? avatar,
    bool? emailVerified,
  }) {
    _name = name;
    _email = email;
    _avatar = avatar;
    _emailVerified = emailVerified;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'] as String;
    _email = json['email'] as String;
    _avatar = json['avatar'] as String;
    _emailVerified = json['emailVerified'] as bool;
  }
  String? _name;
  String? _email;
  String? _avatar;
  bool? _emailVerified;

  // UserModel copyWith({
  //   String? name,
  //   String? email,
  //   String? avatar,
  //   bool? emailVerified,
  // }) => UserModel(
  //   name: name ?? _name,
  //   email: email ?? _email,
  //   avatar: avatar ?? _avatar,
  //   emailVerified: emailVerified ?? _emailVerified,
  // );
  // String? get name => _name;
  // String? get email => _email;
  // String? get avatar => _avatar;
  // bool? get emailVerified => _emailVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['avatar'] = _avatar;
    map['emailVerified'] = _emailVerified;
    return map;
  }
}


class TokenModel {
  TokenModel({this.auth_token, this.refreshCat});

  TokenModel.fromJson(Map<String, dynamic> json) {
    auth_token = json['auth_token'];
    refreshCat = json['refresh_cat'];
  }

  String? auth_token;
  String? refreshCat;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['auth_token'] = auth_token;
    data['refresh_cat'] = refreshCat;
    return data;
  }
}
