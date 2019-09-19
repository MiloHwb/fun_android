import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

const bool inProduction = const bool.fromEnvironment('dart.vm.product');

class PlatformUtils {
  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    return (await getAppPackageInfo()).version;
  }

  static Future<dynamic> getDeviceInfo() {
    var deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      return deviceInfoPlugin.androidInfo;
    } else if (Platform.isIOS) {
      return deviceInfoPlugin.iosInfo;
    } else {
      return null;
    }
  }
}
