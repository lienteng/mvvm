class ApiConstants {
  static const String baseUrl = 'https://api-v2.super-vip.online/api/v2';

  // Endpoints
  static const String reportProblems = '/work/problem/by/employee';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
