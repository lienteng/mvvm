import 'package:flutter/material.dart';
import 'app_localizations.dart';
import 'app_localizations_en.dart';
import 'app_localizations_lo.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'lo', 'th', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'lo':
        return AppLocalizationsLo();
      case 'th':
        return AppLocalizationsTh();
      case 'zh':
        return AppLocalizationsZh();
      case 'en':
      default:
        return AppLocalizationsEn();
    }
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
