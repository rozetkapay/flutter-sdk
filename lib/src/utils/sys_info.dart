import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SysInfo {
  //
  static const keySdkVersion = "sdk_version";
  static const keyPlatform = "platform";
  static const keyOsVersion = "os_version";
  static const keyOsBuildVersion = "os_build_version";
  static const keyOsBuildNumber = "os_build_number";
  static const keyDeviceId = "device_id";

  Map<String, String>? sysInfo;

  Future<Map<String, String>> get() async {
    if (sysInfo == null) {
      sysInfo = await _deviceInfo();
      sysInfo![keySdkVersion] = await _sdkVersion();
    }
    return sysInfo!;
  }

  Future<String> _sdkVersion() async {
    final package = await PackageInfo.fromPlatform();
    return "${package.version}+${package.buildNumber}";
  }

  Future<Map<String, String>> _deviceInfo() => Platform.isIOS
      ? _ios()
      : Platform.isAndroid
          ? _android()
          : _unknown();

  Future<Map<String, String>> _android() async {
    final device = DeviceInfoPlugin();
    final androidInfo = await device.androidInfo;
    return {
      keyPlatform: "android",
      keyOsVersion: androidInfo.version.release,
      keyOsBuildVersion: androidInfo.version.sdkInt.toString(),
      keyOsBuildNumber: androidInfo.version.incremental,
      keyDeviceId: androidInfo.id,
    };
  }

  Future<Map<String, String>> _ios() async {
    final device = DeviceInfoPlugin();
    final iosInfo = await device.iosInfo;

    return {
      keyPlatform: "ios",
      keyOsVersion: iosInfo.systemVersion,
      keyOsBuildVersion: iosInfo.utsname.version,
      keyOsBuildNumber: iosInfo.utsname.release,
      keyDeviceId: iosInfo.identifierForVendor ?? "",
    };
  }

  Future<Map<String, String>> _unknown() async => {
        keyPlatform: "",
        keyOsVersion: "",
        keyOsBuildVersion: "",
        keyOsBuildNumber: "",
        keyDeviceId: "",
      };

  // singleton
  factory SysInfo() => _one;
  static final _one = SysInfo._();
  SysInfo._();
}
