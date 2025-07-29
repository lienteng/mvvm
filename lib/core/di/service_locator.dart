import 'package:get_it/get_it.dart';
import 'package:mvvm/features/biometric_attendance/repositories/attendance_repository.dart';
import 'package:mvvm/features/biometric_attendance/services/biometric_service.dart';
import 'package:mvvm/features/biometric_attendance/viewmodels/attendance_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/report_problem/repositories/report_problem_repository.dart';
import '../../features/report_problem/viewmodels/report_problem_viewmodel.dart';
import '../../features/home/repositories/home_repository.dart';
import '../../features/home/viewmodels/home_viewmodel.dart';

import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/viewmodels/auth_viewmodel.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static T get<T extends Object>() => _getIt<T>();

  static Future<void> init() async {
    // SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // Services
    _getIt.registerLazySingleton<StorageService>(
      () => StorageService(_getIt<SharedPreferences>()),
    );
    _getIt.registerLazySingleton<ApiService>(() => ApiService());
    _getIt.registerLazySingleton<BiometricService>(() => BiometricService());

    // Auth Repository
    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(_getIt<ApiService>(), _getIt<StorageService>()),
    );

    // Auth ViewModel
    _getIt.registerFactory<AuthViewModel>(
      () => AuthViewModel(_getIt<AuthRepository>()),
    );

    // Home Repository
    _getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepository(_getIt<ApiService>()),
    );

    // Home ViewModel
    _getIt.registerFactory<HomeViewModel>(
      () => HomeViewModel(_getIt<HomeRepository>()),
    );

    // Report Problem Repository
    _getIt.registerLazySingleton<ReportProblemRepository>(
      () => ReportProblemRepository(_getIt<ApiService>()),
    );

    // Report Problem ViewModel
    _getIt.registerFactory<ReportProblemViewModel>(
      () => ReportProblemViewModel(_getIt<ReportProblemRepository>()),
    );

    // Biometric Attendance Repository
    _getIt.registerLazySingleton<AttendanceRepository>(
      () =>
          AttendanceRepository(_getIt<ApiService>(), _getIt<StorageService>()),
    );

    // Biometric Attendance ViewModel
    _getIt.registerFactory<AttendanceViewModel>(
      () => AttendanceViewModel(
        _getIt<AttendanceRepository>(),
        _getIt<BiometricService>(),
      ),
    );
  }
}
