import 'package:flutter/material.dart';
import '../services/storage_service.dart';

enum SupportedLanguage {
  english('en', 'English'),
  lao('lo', 'ລາວ'),
  thai('th', 'ไทย'),
  chinese('zh', '中文');

  const SupportedLanguage(this.code, this.name);
  final String code;
  final String name;
}

class LanguageService extends ChangeNotifier {
  final StorageService _storageService;

  static const String _languageKey = 'selected_language';

  SupportedLanguage _currentLanguage = SupportedLanguage.english;

  LanguageService(this._storageService) {
    _loadLanguage();
  }

  SupportedLanguage get currentLanguage => _currentLanguage;

  Locale get currentLocale => Locale(_currentLanguage.code);

  List<SupportedLanguage> get supportedLanguages => SupportedLanguage.values;

  Future<void> changeLanguage(SupportedLanguage language) async {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      await _storageService.setString(_languageKey, language.code);
      notifyListeners();
    }
  }

  Future<void> _loadLanguage() async {
    try {
      final languageCode = _storageService.getString(_languageKey);
      if (languageCode != null) {
        _currentLanguage = SupportedLanguage.values.firstWhere(
          (lang) => lang.code == languageCode,
          orElse: () => SupportedLanguage.english,
        );
        notifyListeners();
      }
    } catch (e) {
      print('LanguageService: Error loading language: $e');
    }
  }

  String getLanguageDisplayName(SupportedLanguage language) {
    return language.name;
  }

  bool isCurrentLanguage(SupportedLanguage language) {
    return _currentLanguage == language;
  }

  Future<void> resetToDefault() async {
    await changeLanguage(SupportedLanguage.english);
  }
}
