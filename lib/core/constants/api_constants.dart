class ApiConstants {
  static const String baseUrl = 'https://api-v2.super-vip.online/api/v2';
  // static const String baseUrl = 'http://192.168.1.10:3001/api/v2';

  // Endpoints
  static const String reportProblems = '/work/problem/by/employee';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String userUpdate = '/user/update';
  static const String userChangePassword = '/user/change-password';
  static const String getUsers = '/user/by/id';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';

  // Time Tracking Endpoints
  static const String timesList = '/check/in/out/time/listv2';
  static const String checkIn = '/times/check-in';
  static const String checkOut = '/times/check-out';

  // Home Endpoints
  static const String menuItems = '/home/menu-items';
  static const String banners = '/home/banners';
  static const String recentTransactions = '/home/recent-transactions';
  static const String notifications = '/notifications';

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
}
