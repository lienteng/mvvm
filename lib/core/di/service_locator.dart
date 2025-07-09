import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/report_problem/repositories/report_problem_repository.dart';
import '../../features/report_problem/viewmodels/report_problem_viewmodel.dart';
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

    // Auth Repository
    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(_getIt<ApiService>(), _getIt<StorageService>()),
    );

    // Auth ViewModel
    _getIt.registerFactory<AuthViewModel>(
      () => AuthViewModel(_getIt<AuthRepository>()),
    );
    
    // Repositories
    _getIt.registerLazySingleton<ReportProblemRepository>(
      () => ReportProblemRepository(_getIt<ApiService>()),
    );
    
    // ViewModels
    _getIt.registerFactory<ReportProblemViewModel>(
      () => ReportProblemViewModel(_getIt<ReportProblemRepository>()),
    );
  }
}
