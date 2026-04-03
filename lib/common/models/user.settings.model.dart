class UserSettingsModel {
  UserSettingsModel({
    required this.firstLaunch,
    required this.isLoggedIn,
    required this.userName,
  });

  UserSettingsModel.fromJson(Map<String, dynamic> json) {
    firstLaunch = json['firstLaunch'];
    isLoggedIn = json['isLoggedIn'];
    userName = json['name'];
  }

  bool? firstLaunch;
  bool? isLoggedIn;
  String? userName;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstLaunch'] = firstLaunch;
    data['isLoggedIn'] = isLoggedIn;
    data['name'] = userName;
    return data;
  }

  static final UserSettingsModel empty = UserSettingsModel(
    firstLaunch: true,
    isLoggedIn: false,
    userName: '',
  );
}
