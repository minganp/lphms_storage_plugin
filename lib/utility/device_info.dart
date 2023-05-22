
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
class DeviceInfo {
  String? _os; //operating system
  String? _model;
  String? _id;
  DeviceInfo._();
  static Future<DeviceInfo> retrieve() async {
    var deviceInfo = DeviceInfo._();
    await deviceInfo._retrieveDevice();
    return deviceInfo;
  }
  Future<void> _retrieveDevice() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      _os = "android";
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      _model = androidDeviceInfo.model;
      _id = androidDeviceInfo.id;
    } else if (Platform.isIOS) {
      _os = "ios";
      var info = await DeviceInfoPlugin().iosInfo;
      _model = info.utsname.machine;
      _id = info.identifierForVendor;
    } else if (Platform.isWindows) {
      _os = "windows";
      WindowsDeviceInfo windowsDeviceInfo = await deviceInfoPlugin.windowsInfo;
      _model = windowsDeviceInfo.computerName;
      _id = windowsDeviceInfo.computerName;
    } else {
      _os = Platform.operatingSystem;
      _model = "unknown";
      _id = "unknown";
    }
  }
  get os => _os;
  get model => _model;
  get   id => _id;
}
