import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  DeviceInfo({
    required this.deviceId,
    required this.model,
    required this.osVersion,
    required this.manufacturer,
    required this.os,
    required this.appVersion,
    required this.buildNumber,
  });

  final String deviceId;
  final String model;
  final String osVersion;
  final String manufacturer;
  final String os;
  final String appVersion;
  final String buildNumber;

  static Future<DeviceInfo> getDeviceDetails() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    var deviceId = '';
    var model = '';
    var osVersion = '';
    var manufacturer = '';
    final os = Platform.operatingSystem;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
      model = androidInfo.model;
      osVersion = androidInfo.version.release;
      manufacturer = androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'Unknown';
      model = iosInfo.utsname.machine;
      osVersion = iosInfo.systemVersion;
      manufacturer = 'Apple';
    }

    return DeviceInfo(
      deviceId: deviceId,
      model: model,
      osVersion: osVersion,
      manufacturer: manufacturer,
      os: os,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }

  @override
  String toString() {
    return 'Device ID: $deviceId\n'
        'Model: $model\n'
        'OS Version: $osVersion\n'
        'Manufacturer: $manufacturer\n'
        'OS: $os\n'
        'App Version: $appVersion\n'
        'Build Number: $buildNumber';
  }
}
