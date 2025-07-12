import 'menu_item.dart';
import 'banner_item.dart';
import 'transaction_item.dart';
import 'notification_item.dart';
import 'time_schedule.dart';

class HomeData {
  final List<MenuItem> menuItems;
  final List<BannerItem> banners;
  final List<TransactionItem> recentTransactions;
  final List<NotificationItem> notifications;
  final List<TimeSchedule> timeSchedules;
  final DateTime lastUpdated;

  HomeData({
    required this.menuItems,
    required this.banners,
    required this.recentTransactions,
    required this.notifications,
    required this.timeSchedules,
    required this.lastUpdated,
  });

  HomeData copyWith({
    List<MenuItem>? menuItems,
    List<BannerItem>? banners,
    List<TransactionItem>? recentTransactions,
    List<NotificationItem>? notifications,
    List<TimeSchedule>? timeSchedules,
    DateTime? lastUpdated,
  }) {
    return HomeData(
      menuItems: menuItems ?? this.menuItems,
      banners: banners ?? this.banners,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      notifications: notifications ?? this.notifications,
      timeSchedules: timeSchedules ?? this.timeSchedules,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
