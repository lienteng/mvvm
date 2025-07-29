import 'package:flutter/material.dart';
import 'package:mvvm/features/users/models/user_model.dart';
import '../models/home_data.dart';
import '../models/menu_item.dart';
import '../models/banner_item.dart';
import '../models/transaction_item.dart';
import '../models/notification_item.dart';
import '../models/time_schedule.dart';
import '../repositories/home_repository.dart';
import '../../../core/models/app_error.dart';

enum HomeLoadingState { initial, loading, loaded, error, refreshing }

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _homeRepository;

  HomeViewModel(this._homeRepository);

  // State
  HomeData? _homeData;
  HomeLoadingState _loadingState = HomeLoadingState.initial;
  AppError? _error;
  String? _successMessage;
  DateTime? _lastRefresh;
  bool _isCheckingIn = false;
  bool _isCheckingOut = false;

  // Getters
  HomeData? get homeData => _homeData;
  HomeLoadingState get loadingState => _loadingState;
  AppError? get error => _error;
  String? get errorMessage => _error?.userFriendlyMessage;
  String? get successMessage => _successMessage;
  DateTime? get lastRefresh => _lastRefresh;
  bool get isCheckingIn => _isCheckingIn;
  bool get isCheckingOut => _isCheckingOut;

  // Convenience getters
  List<MenuItem> get menuItems => _homeData?.menuItems ?? [];
  List<BannerItem> get banners => _homeData?.banners ?? [];
  List<TransactionItem> get recentTransactions =>
      _homeData?.recentTransactions ?? [];
  List<NotificationItem> get notifications => _homeData?.notifications ?? [];
  List<TimeSchedule> get timeSchedules => _homeData?.timeSchedules ?? [];
  int get unreadNotificationCount =>
      notifications.where((n) => !n.isRead).length;
  UserModel? get user => _homeData?.user;

  bool get isLoading => _loadingState == HomeLoadingState.loading;
  bool get isRefreshing => _loadingState == HomeLoadingState.refreshing;
  bool get hasError => _loadingState == HomeLoadingState.error;
  bool get hasData => _homeData != null;
  bool get canRetry => _error?.canRetry ?? true;

  // Error type checks
  bool get isNetworkError => _error?.isNetworkError ?? false;
  bool get isServerError => _error?.isServerError ?? false;
  bool get isApiResponseError => _error?.isApiResponseError ?? false;

  // Time tracking getters
  TimeSchedule? get todaySchedule {
    final today = DateTime.now();
    final todayString =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    try {
      return timeSchedules.firstWhere(
        (schedule) => schedule.scheduleDate == todayString,
      );
    } catch (e) {
      return null;
    }
  }

  bool get canCheckIn {
    final schedule = todaySchedule;
    if (schedule == null) return false;

    final now = TimeOfDay.now();
    final startTime = schedule.startTime;

    // Can check in 30 minutes before start time
    final canCheckInTime = TimeOfDay(
      hour: startTime.hour,
      minute: startTime.minute - 30,
    );

    return _isTimeAfter(now, canCheckInTime) && !schedule.isCheckIn;
  }

  bool get canCheckOut {
    final schedule = todaySchedule;
    if (schedule == null) return false;

    final now = TimeOfDay.now();
    final endTime = schedule.endTime;

    return _isTimeAfter(now, endTime) && schedule.isCheckIn;
  }

  // Load initial data
  Future<void> loadHomeData() async {
    if (_loadingState == HomeLoadingState.loading) return;

    debugPrint('HomeViewModel: Loading home data');
    _setLoadingState(HomeLoadingState.loading);
    _clearError();

    try {
      final homeData = await _homeRepository.fetchHomeData();

      debugPrint("HomeViewModel: Home data loaded successfully $homeData");
      _homeData = homeData;
      _lastRefresh = DateTime.now();
      _setLoadingState(HomeLoadingState.loaded);
      debugPrint('HomeViewModel: Home data loaded successfully');
    } on AppError catch (e) {
      debugPrint('HomeViewModel: AppError loading home data: $e');
      _setError(e);
      _setLoadingState(HomeLoadingState.error);
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error loading home data: $e');
      _setError(AppError.unknown('Failed to load data', originalError: e));
      _setLoadingState(HomeLoadingState.error);
    }
  }

  // Refresh data (pull-to-refresh)
  Future<void> refreshHomeData() async {
    if (_loadingState == HomeLoadingState.loading ||
        _loadingState == HomeLoadingState.refreshing)
      return;

    debugPrint('HomeViewModel: Refreshing home data');
    _setLoadingState(HomeLoadingState.refreshing);
    _clearError();

    try {
      final homeData = await _homeRepository.fetchHomeData();
      _homeData = homeData;
      _lastRefresh = DateTime.now();
      _setLoadingState(HomeLoadingState.loaded);
      debugPrint('HomeViewModel: Home data refreshed successfully');
    } on AppError catch (e) {
      debugPrint('HomeViewModel: AppError refreshing home data: $e');
      _setError(e);
      _setLoadingState(HomeLoadingState.error);
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error refreshing home data: $e');
      _setError(AppError.unknown('Failed to refresh data', originalError: e));
      _setLoadingState(HomeLoadingState.error);
    }
  }

  // Check in
  Future<bool> checkIn({
    required double latitude,
    required double longitude,
  }) async {
    final schedule = todaySchedule;
    if (schedule == null) {
      _setError(AppError.unknown('No schedule found for today'));
      return false;
    }

    if (_isCheckingIn) return false;

    debugPrint('HomeViewModel: Starting check-in process');
    _setCheckingIn(true);
    _clearMessages();

    try {
      final response = await _homeRepository.checkIn(
        scheduleId: schedule.scheduleId,
        latitude: latitude,
        longitude: longitude,
      );

      _setSuccess('Check-in successful!');
      // Refresh the home data
      await refreshHomeData();
      debugPrint('HomeViewModel: Check-in completed successfully');
      return true;
    } on AppError catch (e) {
      debugPrint('HomeViewModel: AppError during check-in: $e');
      _setError(e);
      return false;
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error during check-in: $e');
      _setError(AppError.unknown('Check-in failed', originalError: e));
      return false;
    } finally {
      _setCheckingIn(false);
    }
  }

  // Check out
  Future<bool> checkOut({
    required double latitude,
    required double longitude,
  }) async {
    final schedule = todaySchedule;
    if (schedule == null) {
      _setError(AppError.unknown('No schedule found for today'));
      return false;
    }

    if (_isCheckingOut) return false;

    debugPrint('HomeViewModel: Starting check-out process');
    _setCheckingOut(true);
    _clearMessages();

    try {
      final response = await _homeRepository.checkOut(
        scheduleId: schedule.scheduleId,
        latitude: latitude,
        longitude: longitude,
      );

      _setSuccess('Check-out successful!');
      // Refresh the home data
      await refreshHomeData();
      debugPrint('HomeViewModel: Check-out completed successfully');
      return true;
    } on AppError catch (e) {
      debugPrint('HomeViewModel: AppError during check-out: $e');
      _setError(e);
      return false;
    } catch (e) {
      print('HomeViewModel: Unexpected error during check-out: $e');
      _setError(AppError.unknown('Check-out failed', originalError: e));
      return false;
    } finally {
      _setCheckingOut(false);
    }
  }

  // Update specific sections for real-time updates
  Future<void> updateMenuItems() async {
    try {
      final menuItems = await _homeRepository.fetchMenuItems();
      if (_homeData != null) {
        _homeData = _homeData!.copyWith(menuItems: menuItems);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error updating menu items: $e');
      // Don't show error for individual section updates
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error updating menu items: $e');
    }
  }

  Future<void> updateBanners() async {
    try {
      final banners = await _homeRepository.fetchBanners();
      if (_homeData != null) {
        _homeData = _homeData!.copyWith(banners: banners);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error updating banners: $e');
      // Don't show error for individual section updates
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error updating banners: $e');
    }
  }

  Future<void> updateRecentTransactions() async {
    try {
      final transactions = await _homeRepository.fetchRecentTransactions();
      if (_homeData != null) {
        _homeData = _homeData!.copyWith(recentTransactions: transactions);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error updating recent transactions: $e');
      // Don't show error for individual section updates
    } catch (e) {
      debugPrint(
        'HomeViewModel: Unexpected error updating recent transactions: $e',
      );
    }
  }

  Future<void> updateNotifications() async {
    try {
      final notifications = await _homeRepository.fetchNotifications();
      if (_homeData != null) {
        _homeData = _homeData!.copyWith(notifications: notifications);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error updating notifications: $e');
      // Don't show error for individual section updates
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error updating notifications: $e');
    }
  }

  Future<void> updateTimeSchedules() async {
    try {
      final timeSchedules = await _homeRepository.fetchTimeSchedules();
      if (_homeData != null) {
        _homeData = _homeData!.copyWith(timeSchedules: timeSchedules);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error updating time schedules: $e');
      // Don't show error for individual section updates
    } catch (e) {
      debugPrint('HomeViewModel: Unexpected error updating time schedules: $e');
    }
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(int notificationId) async {
    try {
      await _homeRepository.markNotificationAsRead(notificationId);

      // Update local state
      if (_homeData != null) {
        final updatedNotifications = _homeData!.notifications.map((
          notification,
        ) {
          if (notification.id == notificationId) {
            return NotificationItem(
              id: notification.id,
              title: notification.title,
              message: notification.message,
              type: notification.type,
              isRead: true, // Mark as read
              createdAt: notification.createdAt,
              actionUrl: notification.actionUrl,
              data: notification.data,
            );
          }
          return notification;
        }).toList();

        _homeData = _homeData!.copyWith(notifications: updatedNotifications);
        notifyListeners();
      }
    } on AppError catch (e) {
      debugPrint('HomeViewModel: Error marking notification as read: $e');
      // Don't show error for this action
    } catch (e) {
      debugPrint(
        'HomeViewModel: Unexpected error marking notification as read: $e',
      );
    }
  }

  // Check if data needs refresh (older than 5 minutes)
  bool get needsRefresh {
    if (_lastRefresh == null) return true;
    return DateTime.now().difference(_lastRefresh!).inMinutes > 5;
  }

  // Auto-refresh if needed
  Future<void> autoRefreshIfNeeded() async {
    if (needsRefresh && !isLoading && !isRefreshing) {
      await refreshHomeData();
    }
  }

  // Helper methods
  bool _isTimeAfter(TimeOfDay current, TimeOfDay target) {
    final currentMinutes = current.hour * 60 + current.minute;
    final targetMinutes = target.hour * 60 + target.minute;
    return currentMinutes >= targetMinutes;
  }

  void _setLoadingState(HomeLoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  void _setCheckingIn(bool checking) {
    _isCheckingIn = checking;
    notifyListeners();
  }

  void _setCheckingOut(bool checking) {
    _isCheckingOut = checking;
    notifyListeners();
  }

  void _setError(AppError error) {
    _error = error;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccess(String success) {
    _successMessage = success;
    _error = null;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void _clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearMessages() {
    _clearMessages();
  }

  // Get error details for debugging
  String getErrorDetails() {
    if (_error == null) return 'No error';

    return '''
Error Type: ${_error!.type}
Message: ${_error!.message}
Code: ${_error!.code ?? 'N/A'}
Status Code: ${_error!.statusCode ?? 'N/A'}
Can Retry: ${_error!.canRetry}
User Message: ${_error!.userFriendlyMessage}
''';
  }
}
