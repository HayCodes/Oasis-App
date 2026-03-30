class UserSettingsModel {
  UserSettingsModel({
    required this.firstLaunch,
    required this.isLoggedIn,
    required this.userId,
  });

  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    firstLaunch = json['firstLaunch'];
    isLoggedIn = json['isLoggedIn'];
    userId = json['userId'];
  }

  bool? firstLaunch;
  bool? isLoggedIn;
  String? userId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstLaunch'] = firstLaunch;
    data['isLoggedIn'] = isLoggedIn;
    data['userId'] = userId;
    return data;
  }

  static final UserSettingsModel empty = UserSettingsModel(
    firstLaunch: true,
    isLoggedIn: false,
    userId: '',
  );
}
