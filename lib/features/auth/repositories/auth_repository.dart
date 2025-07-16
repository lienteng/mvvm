import 'dart:convert';
import '../../../core/constants/api_constants.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/login_response.dart';

class AuthRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthRepository(this._apiService, this._storageService);

  Future<LoginResponse> login({
    required String username,
    required String password,
    String? fcmToken,
  }) async {
    final data = {
      'username': username,
      'password': password,
      if (fcmToken != null) 'fcm_token': fcmToken,
    };

    try {
      final response = await _apiService.postAuth<LoginResponse>(
        ApiConstants.login,
        data: data,
        fromJson: LoginResponse.fromJson,
      );

      // Only save auth data if login was successful
      if (response.resCode == '0000' && response.data != null) {
        await _saveAuthData(response);
      }

      return response;
    } catch (e) {
      print('AuthRepository: Login error: $e');
      rethrow;
    }
  }

  Future<LoginResponse> refreshToken() async {
    print('AuthRepository: Attempting token refresh');

    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await _apiService.postAuth<LoginResponse>(
      ApiConstants.refreshToken,
      data: {'refresh_token': refreshToken},
      fromJson: LoginResponse.fromJson,
    );

    // Save new tokens only if refresh was successful
    if (response.resCode == '0000') {
      await _saveAuthData(response);
      print('AuthRepository: Token refresh successful');
    }

    return response;
  }

  Future<void> logout() async {
    print('AuthRepository: Attempting logout');

    try {
      await _apiService.postAuth(
        ApiConstants.logout,
        data: {},
        fromJson: (json) => json,
      );
      print('AuthRepository: Logout API call successful');
    } catch (e) {
      // Continue with logout even if API call fails
      print('AuthRepository: Logout API call failed: $e');
    } finally {
      await _clearAuthData();
      print('AuthRepository: Auth data cleared');
    }
  }

  Future<void> _saveAuthData(LoginResponse loginResponse) async {
    print('AuthRepository: Saving auth data');

    await _storageService.setString(
      ApiConstants.accessTokenKey,
      loginResponse.token!,
    );
    await _storageService.setString(
      ApiConstants.refreshTokenKey,
      loginResponse.refreshToken!,
    );
    await _storageService.setString(
      ApiConstants.userDataKey,
      jsonEncode(loginResponse.data!.toJson()),
    );

    print('AuthRepository: Auth data saved to storage');
  }

  Future<void> _clearAuthData() async {
    await _storageService.remove(ApiConstants.accessTokenKey);
    await _storageService.remove(ApiConstants.refreshTokenKey);
    await _storageService.remove(ApiConstants.userDataKey);
    print('AuthRepository: Auth data cleared from storage');
  }

  Future<String?> getAccessToken() async {
    final token = _storageService.getString(ApiConstants.accessTokenKey);
    print(
      'AuthRepository: Retrieved access token: ${token != null ? 'exists' : 'null'}',
    );
    return token;
  }

  Future<String?> getRefreshToken() async {
    final token = _storageService.getString(ApiConstants.refreshTokenKey);
    print(
      'AuthRepository: Retrieved refresh token: ${token != null ? 'exists' : 'null'}',
    );
    return token;
  }

  Future<UserData?> getUserData() async {
    final userDataString = _storageService.getString(ApiConstants.userDataKey);
    print(
      'AuthRepository: Retrieved user data string: ${userDataString != null ? 'exists' : 'null'}',
    );

    if (userDataString != null) {
      try {
        final userDataJson = jsonDecode(userDataString);
        final userData = UserData.fromJson(userDataJson);
        print(
          'AuthRepository: User data parsed successfully: ${userData.employee.name}',
        );
        return userData;
      } catch (e) {
        print('AuthRepository: Error parsing user data: $e');
        await _clearAuthData();
        return null;
      }
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    final userData = await getUserData();
    final isLoggedIn = token != null && token.isNotEmpty && userData != null;
    print(
      'AuthRepository: isLoggedIn check - token: ${token != null}, userData: ${userData != null}, result: $isLoggedIn',
    );
    return isLoggedIn;
  }

  Future<bool> hasPermission(String permissionName) async {
    final userData = await getUserData();
    if (userData == null) return false;

    return userData.userPermissions.any(
      (permission) => permission.permission.name == permissionName,
    );
  }

  Future<List<String>> getUserRoles() async {
    final userData = await getUserData();
    if (userData == null) return [];

    return userData.userRoles.map((userRole) => userRole.role.name).toList();
  }
}
