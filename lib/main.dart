import 'package:flutter/material.dart';
import 'package:mvvm/core/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_service.dart';
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
      child: Consumer2<AuthViewModel, ThemeService>(
        builder: (context, authViewModel, themeService, child) {
          return MaterialApp.router(
            title: 'Flutter MVVM App',
            theme: themeService.getTheme(context),
            darkTheme: themeService.getTheme(context),
            themeMode: _getThemeMode(themeService.themeMode),
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
