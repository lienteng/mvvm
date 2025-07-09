import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;
  
  StorageService(this._prefs);
  
  // String operations
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }
  
  String? getString(String key) {
    return _prefs.getString(key);
  }
  
  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }
  
  int? getInt(String key) {
    return _prefs.getInt(key);
  }
  
  // Bool operations
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  
  // Remove key
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }
  
  // Clear all
  Future<bool> clear() async {
    return await _prefs.clear();
  }
  
  // Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
