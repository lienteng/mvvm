import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme_service.dart';
import '../../../core/theme/app_theme.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
        actions: [
          Consumer<ThemeService>(
            builder: (context, themeService, child) {
              return IconButton(
                icon: Icon(
                  themeService.isDarkMode(context)
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () => themeService.toggleThemeMode(context),
                tooltip: 'Toggle Theme',
              );
            },
          ),
        ],
      ),
      body: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme Mode Section
                _buildSectionHeader(context, 'Theme Mode'),
                const SizedBox(height: 16),
                _buildThemeModeSelector(context, themeService),
                const SizedBox(height: 32),

                // Theme Color Section
                _buildSectionHeader(context, 'Theme Color'),
                const SizedBox(height: 16),
                _buildThemeColorSelector(context, themeService),
                const SizedBox(height: 32),

                // Preview Section
                _buildSectionHeader(context, 'Preview'),
                const SizedBox(height: 16),
                _buildPreviewSection(context),
                const SizedBox(height: 32),

                // Reset Section
                _buildResetSection(context, themeService),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildThemeModeSelector(
    BuildContext context,
    ThemeService themeService,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: AppThemeMode.values.map((mode) {
            return RadioListTile<AppThemeMode>(
              title: Text(themeService.getThemeModeDisplayName(mode)),
              subtitle: Text(_getThemeModeDescription(mode)),
              value: mode,
              groupValue: themeService.themeMode,
              onChanged: (AppThemeMode? value) {
                if (value != null) {
                  themeService.setThemeMode(value);
                }
              },
              secondary: Icon(_getThemeModeIcon(mode)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildThemeColorSelector(
    BuildContext context,
    ThemeService themeService,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Color Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: AppThemeColor.values.length,
              itemBuilder: (context, index) {
                final color = AppThemeColor.values[index];
                final isSelected = themeService.themeColor == color;

                return GestureDetector(
                  onTap: () => themeService.setThemeColor(color),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeService.getThemeColorValue(color),
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 3,
                            )
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: themeService
                                    .getThemeColorValue(color)
                                    .withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isSelected)
                          const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        const SizedBox(height: 8),
                        Text(
                          themeService.getThemeColorDisplayName(color),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Component Preview',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Buttons Preview
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Elevated'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Text'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Input Preview
            TextField(
              decoration: const InputDecoration(
                labelText: 'Sample Input',
                hintText: 'Enter text here',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 16),

            // Switch and Checkbox Preview
            Row(
              children: [
                Switch(value: true, onChanged: (value) {}),
                const SizedBox(width: 16),
                Checkbox(value: true, onChanged: (value) {}),
                const SizedBox(width: 16),
                const Text('Sample Controls'),
              ],
            ),
            const SizedBox(height: 16),

            // Progress Indicator Preview
            const LinearProgressIndicator(value: 0.7),
            const SizedBox(height: 8),
            const Text('Progress: 70%'),
          ],
        ),
      ),
    );
  }

  Widget _buildResetSection(BuildContext context, ThemeService themeService) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Settings',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Reset theme settings to default values',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showResetDialog(context, themeService),
                icon: const Icon(Icons.restore),
                label: const Text('Reset to Defaults'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeModeDescription(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return 'Always use light theme';
      case AppThemeMode.dark:
        return 'Always use dark theme';
      case AppThemeMode.system:
        return 'Follow system settings';
    }
  }

  IconData _getThemeModeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.settings_system_daydream;
    }
  }

  void _showResetDialog(BuildContext context, ThemeService themeService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Theme Settings'),
        content: const Text(
          'Are you sure you want to reset all theme settings to their default values?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              themeService.resetToDefaults();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Theme settings reset to defaults'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
