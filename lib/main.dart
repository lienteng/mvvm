import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mvvm/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_service.dart';
import 'core/localization/language_service.dart';
import 'core/localization/app_localizations_delegate.dart';
import 'features/report_problem/viewmodels/report_problem_viewmodel.dart';
import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/auth/viewmodels/auth_viewmodel.dart';
import 'features/biometric_attendance/viewmodels/attendance_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize service locator
  await ServiceLocator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<ThemeService>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<LanguageService>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<AuthViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<HomeViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<ReportProblemViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceLocator.get<AttendanceViewModel>(),
        ),
      ],
      child: Consumer3<AuthViewModel, ThemeService, LanguageService>(
        builder:
            (context, authViewModel, themeService, languageService, child) {
              return MaterialApp.router(
                title: 'Flutter MVVM App',
                theme: themeService.getTheme(context),
                darkTheme: themeService.getTheme(context),
                themeMode: _getThemeMode(themeService.themeMode),
                locale: languageService.currentLocale,
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English
                  Locale('lo', ''), // Lao
                  Locale('th', ''), // Thai
                  Locale('zh', ''), // Chinese
                ],
                routerConfig: AppRouter.createRouter(authViewModel),
                debugShowCheckedModeBanner: false,
              );
            },
      ),
    );
  }

  ThemeMode _getThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
