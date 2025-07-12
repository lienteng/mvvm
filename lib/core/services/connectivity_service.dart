import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:network_info_plus/network_info_plus.dart';

class ConnectivityService {
  // static final Connectivity _connectivity = Connectivity();
  // static final NetworkInfo _networkInfo = NetworkInfo();

  /// ✅ 1) ใช้ DNS lookup เพื่อเช็คว่าออกอินเทอร์เน็ตได้จริง
  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> canReachServer(String host) async {
    try {
      final result = await InternetAddress.lookup(host);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  // /// ✅ 2) ใช้ ConnectivityPlus ตรวจว่าเชื่อมต่ออะไรอยู่ (WiFi, Mobile, None)
  // static Future<List<ConnectivityResult>> getConnectivityType() async {
  //   return await _connectivity.checkConnectivity();
  // }

  // /// ✅ 3) ดึงข้อมูล Network info (SSID, IP)
  // static Future<String?> getWifiName() async {
  //   return await _networkInfo.getWifiName();
  // }

  // static Future<String?> getWifiIP() async {
  //   return await _networkInfo.getWifiIP();
  // }

  // /// ✅ ฟังการเปลี่ยนแปลงแบบ Real-time
  // static Stream<List<ConnectivityResult>> get onConnectivityChanged =>
  //     _connectivity.onConnectivityChanged;
}
