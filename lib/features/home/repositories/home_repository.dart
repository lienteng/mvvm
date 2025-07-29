import 'package:flutter/material.dart';
import 'package:mvvm/features/users/models/user_model.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/app_error.dart';
import '../../../core/services/api_service.dart';
import '../models/menu_item.dart';
import '../models/banner_item.dart';
import '../models/transaction_item.dart';
import '../models/notification_item.dart';
import '../models/time_schedule.dart';
import '../models/home_data.dart';

class HomeRepository {
  final ApiService _apiService;

  HomeRepository(this._apiService);

  // Fetch all home data concurrently with proper error handling
  Future<HomeData> fetchHomeData() async {
    print('HomeRepository: Starting concurrent fetch of all home data');

    try {
      // Execute all API calls concurrently and handle individual failures
      final results = await Future.wait([
        _fetchUserSafely(),
        _fetchMenuItemsSafely(),
        _fetchBannersSafely(),
        _fetchRecentTransactionsSafely(),
        _fetchNotificationsSafely(),
        _fetchTimeSchedulesSafely(),
      ]);
      final user = results[0] as UserModel?;
      if (user == null) {
        throw AppError.unknown('User data is null');
      }
      final menuItems = results[1] as List<MenuItem>;
      final banners = results[2] as List<BannerItem>;
      final recentTransactions = results[3] as List<TransactionItem>;
      final notifications = results[4] as List<NotificationItem>;
      final timeSchedules = results[5] as List<TimeSchedule>;

      debugPrint('HomeRepository: All data fetched successfully');

      return HomeData(
        user: user,
        menuItems: menuItems,
        banners: banners,
        recentTransactions: recentTransactions,
        notifications: notifications,
        timeSchedules: timeSchedules,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      debugPrint('HomeRepository: Error fetching home data: $e');

      // If it's an AppError, rethrow it
      if (e is AppError) {
        rethrow;
      }

      // Otherwise, wrap it in an AppError
      throw AppError.unknown('Failed to load home data', originalError: e);
    }
  }

  // Safe fetch methods that handle errors gracefully
  Future<List<MenuItem>> _fetchMenuItemsSafely() async {
    try {
      return await _fetchMenuItems();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching menu items: $e');
      _logDetailedError('Menu Items', e);
      return []; // Return empty list on error
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error fetching menu items: $e');
      return [];
    }
  }

  Future<List<BannerItem>> _fetchBannersSafely() async {
    try {
      return await _fetchBanners();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching banners: $e');
      _logDetailedError('Banners', e);
      return []; // Return empty list on error
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error fetching banners: $e');
      return [];
    }
  }

  Future<List<TransactionItem>> _fetchRecentTransactionsSafely() async {
    try {
      return await _fetchRecentTransactions();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching recent transactions: $e');
      _logDetailedError('Recent Transactions', e);
      return []; // Return empty list on error
    } catch (e) {
      debugPrint(
        'HomeRepository: Unexpected error fetching recent transactions: $e',
      );
      return [];
    }
  }

  Future<List<NotificationItem>> _fetchNotificationsSafely() async {
    try {
      return await _fetchNotifications();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching notifications: $e');
      _logDetailedError('Notifications', e);
      return []; // Return empty list on error
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error fetching notifications: $e');
      return [];
    }
  }

  Future<List<TimeSchedule>> _fetchTimeSchedulesSafely() async {
    try {
      return await _fetchTimeSchedules();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching time schedules: $e');
      _logDetailedError('Time Schedules', e);
      return []; // Return empty list on error
    } catch (e) {
      debugPrint(
        'HomeRepository: Unexpected error fetching time schedules: $e',
      );
      return [];
    }
  }

  Future<UserModel?> _fetchUserSafely() async {
    try {
      return await _fetchUser();
    } on AppError catch (e) {
      debugPrint('HomeRepository: Error fetching user: $e');
      _logDetailedError('User Fetch', e);
      return null; // ✅ Return null instead of []
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error fetching user: $e');
      return null; // ✅ Return null instead of []
    }
  }

  // Individual fetch methods that throw AppErrors
  Future<List<MenuItem>> _fetchMenuItems() async {
    final response = await _apiService.get<MenuItem>(
      ApiConstants.menuItems,
      fromJson: MenuItem.fromJson,
    );
    return response.data;
  }

  Future<List<BannerItem>> _fetchBanners() async {
    final response = await _apiService.get<BannerItem>(
      ApiConstants.banners,
      fromJson: BannerItem.fromJson,
    );
    return response.data;
  }

  Future<List<TransactionItem>> _fetchRecentTransactions() async {
    final response = await _apiService.get<TransactionItem>(
      ApiConstants.recentTransactions,
      queryParameters: {'limit': 10}, // Limit to recent 10
      fromJson: TransactionItem.fromJson,
    );
    return response.data;
  }

  Future<List<NotificationItem>> _fetchNotifications() async {
    final response = await _apiService.get<NotificationItem>(
      ApiConstants.notifications,
      queryParameters: {
        'limit': 5,
        'unread_only': false,
      }, // Limit to 5 notifications
      fromJson: NotificationItem.fromJson,
    );
    return response.data;
  }

  Future<List<TimeSchedule>> _fetchTimeSchedules() async {
    try {
      final data = {"empId": 36};
      final response = await _apiService.getDataByBody<TimeSchedule>(
        ApiConstants.timesList,
        data: data,
        fromJson: TimeSchedule.fromJson,
      );
      debugPrint('HomeRepository: Fetched time schedules: ${response.data}');
      return response.data;
    } catch (e) {
      debugPrint('HomeRepository: Error fetching time schedules: $e');
      throw AppError.unknown(
        'Failed to fetch time schedules',
        originalError: e,
      );
    }
  }

  Future<UserModel> _fetchUser() async {
    try {
      debugPrint('HomeRepository: Fetching user data');

      final response = await _apiService.getSingle<UserModel>(
        '${ApiConstants.getUsers}/116',
        fromJson: UserModel.fromJson,
      );

      if (response.data.id == 0) {
        throw AppError.unknown('User data is null');
      }

      debugPrint(
        'HomeRepository: User fetched successfully: ${response.message}',
      );

      return response.data; // Return the UserModel inside the wrapper
    } catch (e) {
      debugPrint('HomeRepository: Error fetching user: $e');
      throw AppError.unknown('Failed to fetch user', originalError: e);
    }
  }

  // Time tracking actions with proper error handling
  Future<ApiResponse<TimeSchedule>> checkIn({
    required int scheduleId,
    required double latitude,
    required double longitude,
  }) async {
    debugPrint('HomeRepository: Performing check-in');

    final data = {
      'schedule_id': scheduleId,
      'latitude': latitude,
      'longitude': longitude,
      'check_type': 'IN',
    };

    try {
      final response = await _apiService.post<TimeSchedule>(
        ApiConstants.checkIn,
        data: data,
        fromJson: TimeSchedule.fromJson,
      );

      debugPrint('HomeRepository: Check-in successful');
      return response;
    } on AppError {
      rethrow; // Re-throw AppError as is
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error during check-in: $e');
      throw AppError.unknown('Check-in failed', originalError: e);
    }
  }

  Future<ApiResponse<TimeSchedule>> checkOut({
    required int scheduleId,
    required double latitude,
    required double longitude,
  }) async {
    debugPrint('HomeRepository: Performing check-out');

    final data = {
      'schedule_id': scheduleId,
      'latitude': latitude,
      'longitude': longitude,
      'check_type': 'OUT',
    };

    try {
      final response = await _apiService.post<TimeSchedule>(
        ApiConstants.checkOut,
        data: data,
        fromJson: TimeSchedule.fromJson,
      );

      debugPrint('HomeRepository: Check-out successful');
      return response;
    } on AppError {
      rethrow; // Re-throw AppError as is
    } catch (e) {
      debugPrint('HomeRepository: Unexpected error during check-out: $e');
      throw AppError.unknown('Check-out failed', originalError: e);
    }
  }

  // Individual update methods for real-time updates
  Future<List<MenuItem>> fetchMenuItems() => _fetchMenuItems();
  Future<List<BannerItem>> fetchBanners() => _fetchBanners();
  Future<List<TransactionItem>> fetchRecentTransactions() =>
      _fetchRecentTransactions();
  Future<List<NotificationItem>> fetchNotifications() => _fetchNotifications();
  Future<List<TimeSchedule>> fetchTimeSchedules() => _fetchTimeSchedules();

  // Mark notification as read
  Future<void> markNotificationAsRead(int notificationId) async {
    try {
      await _apiService.post(
        '${ApiConstants.notifications}/$notificationId/read',
        data: {},
        fromJson: (json) => json,
      );
    } on AppError {
      rethrow;
    } catch (e) {
      debugPrint('HomeRepository: Error marking notification as read: $e');
      throw AppError.unknown(
        'Failed to mark notification as read',
        originalError: e,
      );
    }
  }

  // Helper method to log detailed error information
  void _logDetailedError(String section, AppError error) {
    debugPrint('=== ERROR DETAILS for $section ===');
    debugPrint('Type: ${error.type}');
    debugPrint('Message: ${error.message}');
    debugPrint('Code: ${error.code}');
    debugPrint('Status Code: ${error.statusCode}');
    debugPrint('User Friendly: ${error.userFriendlyMessage}');
    debugPrint('Can Retry: ${error.canRetry}');
    debugPrint('================================');
  }
}
