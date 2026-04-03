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