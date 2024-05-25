import 'dart:io';
import 'package:bingo/data/models/devices/device.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:unique_identifier/unique_identifier.dart';

class DeviceInfo {
  static Future<Device> getDeviceData() async {
    DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
    int deviceType = Platform.isAndroid ? 1 : 2;
    String deviceInfo;
    String deviceName;
    String appId;
    String version;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await infoPlugin.androidInfo;
      deviceInfo = androidInfo.brand;
      deviceName = androidInfo.model;
      version = androidInfo.version.release.toString();
      appId = await UniqueIdentifier.serial ?? androidInfo.id.toString();
    } else {
      IosDeviceInfo iosInfo = await infoPlugin.iosInfo;
      deviceInfo = iosInfo.utsname.sysname;
      deviceName = iosInfo.utsname.machine;
      version = iosInfo.utsname.version.toString();
      appId = iosInfo.identifierForVendor.toString().replaceAll('-', '');
    }
    print('object');
    print(appId);
    print('object');
    return Device(
        deviceInfo: deviceInfo,
        imei: appId,
        deviceName: deviceName,
        appVersion: version,
        deviceType: deviceType);
  }
}
