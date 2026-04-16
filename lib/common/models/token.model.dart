class TokenModel {
  const TokenModel({this.value, this.expiry});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      value: json['value'] as String?,
      expiry: json['expiry'] as int?,
    );
  }

  final String? value;
  final int? expiry;
}