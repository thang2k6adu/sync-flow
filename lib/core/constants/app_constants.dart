import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AppConstants {
  static const String appName = 'Vortex Land';
  static const String version = '1.0.0';

  static String? deviceName;
  static String? deviceId;
  static String? deviceModel;
  static String? osVersion;
  static String? osType;
  static String? ipAddress;

  static Future<void> initialize() async {
    final NetworkInfo networkInfo = NetworkInfo();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.brand;
      deviceId = androidInfo.id;
      deviceModel = androidInfo.model;
      osVersion = androidInfo.version.release;
      osType = 'Android';
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.name;
      deviceId = iosInfo.identifierForVendor;
      deviceModel = iosInfo.model;
      osVersion = iosInfo.systemVersion;
      osType = 'iOS';
    } else {
      deviceName = 'Unknown';
      deviceId = 'Unknown';
      deviceModel = 'Unknown';
      osVersion = 'Unknown';
      osType = 'Unknown';
    }

    // Lấy địa chỉ IP
    ipAddress = await networkInfo.getWifiIP();
  }
}