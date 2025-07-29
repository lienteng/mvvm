import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Get unique device ID
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id; // Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown-ios-device';
      }
      return 'unknown-device';
    } catch (e) {
      print('DeviceService: Error getting device ID: $e');
      return 'unknown-device-${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  // Get device info for display
  static Future<Map<String, String>> getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return {
          'platform': 'Android',
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'version': androidInfo.version.release,
          'device_id': androidInfo.id,
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return {
          'platform': 'iOS',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'version': iosInfo.systemVersion,
          'device_id': iosInfo.identifierForVendor ?? 'unknown',
        };
      }
      return {
        'platform': 'Unknown',
        'model': 'Unknown',
        'device_id': 'unknown',
      };
    } catch (e) {
      print('DeviceService: Error getting device info: $e');
      return {
        'platform': 'Unknown',
        'model': 'Unknown',
        'device_id': 'unknown',
      };
    }
  }
}
