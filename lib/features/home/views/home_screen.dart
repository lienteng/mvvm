import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/menu_grid.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/recent_transactions_list.dart';
import '../widgets/notifications_section.dart';
import '../widgets/time_tracking_card.dart';
import '../widgets/error_display_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Keep state alive for performance

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              final unreadCount = homeViewModel.unreadNotificationCount;

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {
                      // Navigate to notifications screen
                    },
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          unreadCount > 99 ? '99+' : unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // Debug button to show error details (remove in production)
          Consumer<HomeViewModel>(
            builder: (context, homeViewModel, child) {
              if (homeViewModel.error != null) {
                return IconButton(
                  icon: const Icon(Icons.bug_report),
                  onPressed: () => _showErrorDetails(context, homeViewModel),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          // Show loading for initial load
          if (homeViewModel.isLoading && !homeViewModel.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading your data...'),
                ],
              ),
            );
          }

          // Show error if no data and has error
          if (homeViewModel.hasError && !homeViewModel.hasData) {
            return ErrorDisplayWidget(
              error: homeViewModel.error!,
              onRetry: homeViewModel.canRetry
                  ? () => homeViewModel.loadHomeData()
                  : null,
              showDetails: true,
            );
          }

          return RefreshIndicator(
            onRefresh: homeViewModel.refreshHomeData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Success/Error Messages
                  if (homeViewModel.successMessage != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade700,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              homeViewModel.successMessage!,
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: homeViewModel.clearMessages,
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),

                  // Error message for partial failures
                  if (homeViewModel.error != null && homeViewModel.hasData)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        border: Border.all(color: Colors.orange.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Some data couldn\'t be loaded',
                                  style: TextStyle(
                                    color: Colors.orange.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  homeViewModel.error!.userFriendlyMessage,
                                  style: TextStyle(
                                    color: Colors.orange.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (homeViewModel.canRetry)
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: homeViewModel.refreshHomeData,
                              iconSize: 20,
                            ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: homeViewModel.clearMessages,
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),

                  // Welcome Section
                  _buildWelcomeSection(context),
                  const SizedBox(height: 24),

                  Text(
                    'user name: ${homeViewModel.user?.userName ?? 'Unknown'}',
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      TextButton(
                        onPressed: () {
                          context.push('/settings');
                        },
                        child: const Text(
                          'Go to Settings',
                          style: TextStyle(color: Colors.purple, fontSize: 16),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push('/biometric-attendance');
                        },
                        child: const Text(
                          'Go to Biometric',
                          style: TextStyle(color: Colors.pink, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push('/language-settings');
                    },
                    child: const Text(
                      'Go to Language Settings',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),

                  // Time Tracking Card
                  TimeTrackingCard(
                    schedule: homeViewModel.todaySchedule,
                    canCheckIn: homeViewModel.canCheckIn,
                    canCheckOut: homeViewModel.canCheckOut,
                    isCheckingIn: homeViewModel.isCheckingIn,
                    isCheckingOut: homeViewModel.isCheckingOut,
                    onCheckIn: () => _handleCheckIn(context),
                    onCheckOut: () => _handleCheckOut(context),
                  ),
                  const SizedBox(height: 24),

                  // Banners
                  if (homeViewModel.banners.isNotEmpty) ...[
                    BannerCarousel(banners: homeViewModel.banners),
                    const SizedBox(height: 24),
                  ] else if (homeViewModel.hasData) ...[
                    _buildEmptySection('Banners', 'No banners available'),
                    const SizedBox(height: 24),
                  ],

                  // Menu Grid
                  if (homeViewModel.menuItems.isNotEmpty) ...[
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    MenuGrid(menuItems: homeViewModel.menuItems),
                    const SizedBox(height: 24),
                  ] else if (homeViewModel.hasData) ...[
                    _buildEmptySection(
                      'Quick Actions',
                      'No menu items available',
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Recent Transactions
                  if (homeViewModel.recentTransactions.isNotEmpty) ...[
                    Text(
                      'Recent Transactions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    RecentTransactionsList(
                      transactions: homeViewModel.recentTransactions,
                    ),
                    const SizedBox(height: 24),
                  ] else if (homeViewModel.hasData) ...[
                    _buildEmptySection(
                      'Recent Transactions',
                      'No recent transactions',
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Notifications
                  if (homeViewModel.notifications.isNotEmpty) ...[
                    Text(
                      'Recent Notifications',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    NotificationsSection(
                      notifications: homeViewModel.notifications,
                      onNotificationTap: (notification) {
                        if (!notification.isRead) {
                          homeViewModel.markNotificationAsRead(notification.id);
                        }
                      },
                    ),
                  ] else if (homeViewModel.hasData) ...[
                    _buildEmptySection('Notifications', 'No notifications'),
                  ],

                  // Loading indicator for refresh
                  if (homeViewModel.isRefreshing)
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 8),
                            Text('Refreshing data...'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Here\'s what\'s happening today',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      if (homeViewModel.lastRefresh != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Last updated: ${_formatTime(homeViewModel.lastRefresh!)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.dashboard,
                  size: 48,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptySection(String title, String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  Future<void> _handleCheckIn(BuildContext context) async {
    // In a real app, you would get the actual location
    // For now, using mock coordinates
    const latitude = 17.975618;
    const longitude = 102.608306;

    final success = await context.read<HomeViewModel>().checkIn(
      latitude: latitude,
      longitude: longitude,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-in successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _handleCheckOut(BuildContext context) async {
    // In a real app, you would get the actual location
    // For now, using mock coordinates
    const latitude = 17.975618;
    const longitude = 102.608306;

    final success = await context.read<HomeViewModel>().checkOut(
      latitude: latitude,
      longitude: longitude,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-out successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showErrorDetails(BuildContext context, HomeViewModel homeViewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error Details'),
        content: SingleChildScrollView(
          child: Text(
            homeViewModel.getErrorDetails(),
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
