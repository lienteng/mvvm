import 'package:flutter/material.dart';
import '../models/notification_item.dart';

class NotificationsSection extends StatelessWidget {
  final List<NotificationItem> notifications;
  final Function(NotificationItem) onNotificationTap;

  const NotificationsSection({
    super.key,
    required this.notifications,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No notifications')),
        ),
      );
    }

    // Show only first 3 notifications for performance
    final displayNotifications = notifications.take(3).toList();

    return Card(
      child: Column(
        children: [
          ...displayNotifications.map(
            (notification) => _NotificationTile(
              notification: notification,
              onTap: () => onNotificationTap(notification),
            ),
          ),
          if (notifications.length > 3)
            ListTile(
              title: Text(
                'View all notifications (${notifications.length})',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                // Navigate to all notifications screen
                print('View all notifications tapped');
              },
            ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const _NotificationTile({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getTypeColor(notification.type).withOpacity(0.1),
        child: Icon(
          _getNotificationIcon(notification.type),
          color: _getTypeColor(notification.type),
          size: 20,
        ),
      ),
      title: Text(
        notification.title,
        style: TextStyle(
          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          Text(
            _formatTime(notification.createdAt),
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
          ),
        ],
      ),
      trailing: !notification.isRead
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'info':
        return Icons.info_outline;
      case 'warning':
        return Icons.warning_outlined;
      case 'success':
        return Icons.check_circle_outline;
      case 'error':
        return Icons.error_outline;
      default:
        return Icons.notifications_outlined;
    }
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'info':
        return Colors.blue;
      case 'warning':
        return Colors.orange;
      case 'success':
        return Colors.green;
      case 'error':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
}
