import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuGrid extends StatelessWidget {
  final List<MenuItem> menuItems;

  const MenuGrid({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    // Filter active menu items and take only first 8 for performance
    final activeMenuItems = menuItems
        .where((item) => item.isActive)
        .take(8)
        .toList();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: activeMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = activeMenuItems[index];
        return _MenuItemCard(menuItem: menuItem);
      },
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  final MenuItem menuItem;

  const _MenuItemCard({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Handle menu item tap
          print('Menu item tapped: ${menuItem.name}');
          // Navigate to route: menuItem.route
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getIconData(menuItem.icon),
                size: 32,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                menuItem.name,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    // Map icon names to IconData
    switch (iconName.toLowerCase()) {
      case 'dashboard':
        return Icons.dashboard;
      case 'person':
        return Icons.person;
      case 'settings':
        return Icons.settings;
      case 'report':
        return Icons.report;
      case 'calendar':
        return Icons.calendar_today;
      case 'money':
        return Icons.attach_money;
      case 'notification':
        return Icons.notifications;
      case 'help':
        return Icons.help;
      default:
        return Icons.apps;
    }
  }
}
