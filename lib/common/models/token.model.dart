// class TokenModel {
//   TokenModel({this.auth_token, this.refreshCat});
//
//   TokenModel.fromJson(Map<String, dynamic> json) {
//     auth_token = json['token'];
//     refreshCat = json['refresh_cat'];
//   }
//
//   String? auth_token;
//   String? refreshCat;
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['token'] = auth_token;
//     data['refresh_cat'] = refreshCat;
//     return data;
//   }
// }

class TokenModel {
  const TokenModel({this.value, this.expiry});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      value: json['value'] as String?, // ✅ matches server field
      expiry: json['expiry'] as int?,
    );
  }

  final String? value;
  final int? expiry;
}