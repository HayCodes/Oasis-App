class UserModel {
  const UserModel({
    this.name,
    this.email,
    this.avatar,
    this.emailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        avatar: json['avatar'] as String?,
        emailVerified: json['emailVerified'] as bool?,
      );

  final String? name;
  final String? email;
  final String? avatar;
  final bool? emailVerified;

  UserModel copyWith({
    String? name,
    String? email,
    String? avatar,
    bool? emailVerified,
  }) =>
      UserModel(
        name: name ?? this.name,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
        emailVerified: emailVerified ?? this.emailVerified,
      );

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'avatar': avatar,
        'emailVerified': emailVerified,
      };
}