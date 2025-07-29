import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'app_theme.dart';

class ThemeService extends ChangeNotifier {
  final StorageService _storageService;

  static const String _themeModeKey = 'theme_mode';
  static const String _themeColorKey = 'theme_color';

  AppThemeMode _themeMode = AppThemeMode.system;
  AppThemeColor _themeColor = AppThemeColor.blue;

  ThemeService(this._storageService) {
    _loadThemeSettings();
  }

  // Getters
  AppThemeMode get themeMode => _themeMode;
  AppThemeColor get themeColor => _themeColor;

  bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  ThemeData getTheme(BuildContext context) {
    return AppTheme.getTheme(
      isDark: isDarkMode(context),
      themeColor: _themeColor,
    );
  }

  // Theme Mode Methods
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
    await _storageService.setString(_themeModeKey, mode.name);
    notifyListeners();
  }

  Future<void> toggleThemeMode(BuildContext context) async {
    final currentIsDark = isDarkMode(context);
    await setThemeMode(currentIsDark ? AppThemeMode.light : AppThemeMode.dark);
  }

  // Theme Color Methods
  Future<void> setThemeColor(AppThemeColor color) async {
    _themeColor = color;
    await _storageService.setString(_themeColorKey, color.name);
    notifyListeners();
  }

  // Load settings from storage
  Future<void> _loadThemeSettings() async {
    try {
      // Load theme mode
      final themeModeString = _storageService.getString(_themeModeKey);
      if (themeModeString != null) {
        _themeMode = AppThemeMode.values.firstWhere(
          (mode) => mode.name == themeModeString,
          orElse: () => AppThemeMode.system,
        );
      }

      // Load theme color
      final themeColorString = _storageService.getString(_themeColorKey);
      if (themeColorString != null) {
        _themeColor = AppThemeColor.values.firstWhere(
          (color) => color.name == themeColorString,
          orElse: () => AppThemeColor.blue,
        );
      }

      notifyListeners();
    } catch (e) {
      print('ThemeService: Error loading theme settings: $e');
    }
  }

  // Get theme mode display name
  String getThemeModeDisplayName(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }

  // Get theme color display name
  String getThemeColorDisplayName(AppThemeColor color) {
    switch (color) {
      case AppThemeColor.blue:
        return 'Blue';
      case AppThemeColor.purple:
        return 'Purple';
      case AppThemeColor.green:
        return 'Green';
      case AppThemeColor.orange:
        return 'Orange';
      case AppThemeColor.red:
        return 'Red';
      case AppThemeColor.teal:
        return 'Teal';
    }
  }

  // Get theme color value
  Color getThemeColorValue(AppThemeColor color) {
    switch (color) {
      case AppThemeColor.blue:
        return const Color(0xFF2196F3);
      case AppThemeColor.purple:
        return const Color(0xFF673AB7);
      case AppThemeColor.green:
        return const Color(0xFF4CAF50);
      case AppThemeColor.orange:
        return const Color(0xFFFF9800);
      case AppThemeColor.red:
        return const Color(0xFFE91E63);
      case AppThemeColor.teal:
        return const Color(0xFF009688);
    }
  }

  // Reset to defaults
  Future<void> resetToDefaults() async {
    _themeMode = AppThemeMode.system;
    _themeColor = AppThemeColor.blue;

    await _storageService.remove(_themeModeKey);
    await _storageService.remove(_themeColorKey);

    notifyListeners();
  }
}
