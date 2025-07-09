import 'package:flutter/foundation.dart';
import '../../../core/utils/app_res_code.dart';
import '../models/login_response.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository);

  // State
  UserData? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;
  bool _isInitialized = false;

  // Getters
  UserData? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;
  bool get isInitialized => _isInitialized;

  // Initialize auth state
  Future<void> initializeAuth() async {
    print('AuthViewModel: Starting initialization');
    _setLoading(true);

    try {
      print('AuthViewModel: Checking if logged in');
      _isLoggedIn = await _authRepository.isLoggedIn();
      print('AuthViewModel: isLoggedIn = $_isLoggedIn');

      if (_isLoggedIn) {
        print('AuthViewModel: Getting user data');
        _currentUser = await _authRepository.getUserData();
        print(
          'AuthViewModel: User data loaded: ${_currentUser?.employee.name}',
        );
      }
    } catch (e) {
      print('AuthViewModel: Error initializing auth: $e');
      _isLoggedIn = false;
      _currentUser = null;
    } finally {
      _isInitialized = true;
      print(
        'AuthViewModel: Initialization completed - isLoggedIn: $_isLoggedIn, isInitialized: $_isInitialized',
      );
      _setLoading(false);
    }
  }

  // Login
  Future<String?> login({
    required String username,
    required String password,
    String? fcmToken,
  }) async {
    print('AuthViewModel: Starting login for user: $username');
    _setLoading(true);
    _clearError();

    try {
      final loginResponse = await _authRepository.login(
        username: username,
        password: password,
        fcmToken: fcmToken,
      );

      print('AuthViewModel: Login response code: ${loginResponse.resCode}');
      print('AuthViewModel: Login response message: ${loginResponse.message}');

      if (AppResCode.isSuccess(loginResponse.resCode)) {
        _currentUser = loginResponse.data;
        _isLoggedIn = true;
        print('AuthViewModel: Login successful');
        notifyListeners();
        return null; // Success
      } else {
        _setError(AppResCode.getErrorMessage(loginResponse.resCode));
        print('AuthViewModel: Login failed: ${loginResponse.message}');
        return loginResponse.resCode; // Return error code
      }
    } catch (e) {
      print('AuthViewModel: Login exception: $e');
      _setError('Network error: ${e.toString()}');
      return '0020'; // Something went wrong
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    print('AuthViewModel: Starting logout');
    _setLoading(true);

    try {
      await _authRepository.logout();
      print('AuthViewModel: Logout successful');
    } catch (e) {
      print('AuthViewModel: Logout error: $e');
    } finally {
      _currentUser = null;
      _isLoggedIn = false;
      print('AuthViewModel: Logout completed');
      _setLoading(false);
    }
  }

  // Refresh token
  Future<bool> refreshToken() async {
    print('AuthViewModel: Refreshing token');
    try {
      final loginResponse = await _authRepository.refreshToken();

      if (AppResCode.isSuccess(loginResponse.resCode)) {
        _currentUser = loginResponse.data;
        _isLoggedIn = true;
        print('AuthViewModel: Token refresh successful');
        notifyListeners();
        return true;
      } else {
        print('AuthViewModel: Token refresh failed');
        await logout();
        return false;
      }
    } catch (e) {
      print('AuthViewModel: Token refresh exception: $e');
      await logout();
      return false;
    }
  }

  // Check permission
  Future<bool> hasPermission(String permissionName) async {
    return await _authRepository.hasPermission(permissionName);
  }

  // Get user roles
  Future<List<String>> getUserRoles() async {
    return await _authRepository.getUserRoles();
  }

  // Check if user has specific role
  Future<bool> hasRole(String roleName) async {
    final roles = await getUserRoles();
    return roles.contains(roleName);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
