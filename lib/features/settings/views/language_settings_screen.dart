import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/localization/language_service.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.languageSettings), elevation: 0),
      body: Consumer<LanguageService>(
        builder: (context, languageService, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Language Section
                _buildSectionHeader(context, l10n.currentLanguage),
                const SizedBox(height: 16),
                _buildCurrentLanguageCard(context, languageService, l10n),
                const SizedBox(height: 32),

                // Available Languages Section
                _buildSectionHeader(context, l10n.selectLanguage),
                const SizedBox(height: 16),
                _buildLanguagesList(context, languageService, l10n),
                const SizedBox(height: 32),

                // Information Section
                _buildInfoSection(context, l10n),
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

  Widget _buildCurrentLanguageCard(
    BuildContext context,
    LanguageService languageService,
    AppLocalizations l10n,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                Icons.language,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.currentLanguage,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    languageService.getLanguageDisplayName(
                      languageService.currentLanguage,
                    ),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagesList(
    BuildContext context,
    LanguageService languageService,
    AppLocalizations l10n,
  ) {
    return Card(
      child: Column(
        children: languageService.supportedLanguages.map((language) {
          final isSelected = languageService.isCurrentLanguage(language);

          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _getLanguageFlag(language),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            title: Text(
              languageService.getLanguageDisplayName(language),
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(_getLanguageSubtitle(language)),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null,
            onTap: () =>
                _changeLanguage(context, languageService, language, l10n),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, AppLocalizations l10n) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.info,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.restartRequired,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageFlag(SupportedLanguage language) {
    switch (language) {
      case SupportedLanguage.english:
        return '🇺🇸';
      case SupportedLanguage.lao:
        return '🇱🇦';
      case SupportedLanguage.thai:
        return '🇹🇭';
      case SupportedLanguage.chinese:
        return '🇨🇳';
    }
  }

  String _getLanguageSubtitle(SupportedLanguage language) {
    switch (language) {
      case SupportedLanguage.english:
        return 'English';
      case SupportedLanguage.lao:
        return 'ພາສາລາວ';
      case SupportedLanguage.thai:
        return 'ภาษาไทย';
      case SupportedLanguage.chinese:
        return '简体中文';
    }
  }

  void _changeLanguage(
    BuildContext context,
    LanguageService languageService,
    SupportedLanguage language,
    AppLocalizations l10n,
  ) {
    if (!languageService.isCurrentLanguage(language)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.selectLanguage),
          content: Text('${l10n.languageChanged}\n${l10n.restartRequired}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                languageService.changeLanguage(language);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.languageChanged),
                    action: SnackBarAction(label: l10n.ok, onPressed: () {}),
                  ),
                );
              },
              child: Text(l10n.ok),
            ),
          ],
        ),
      );
    }
  }
}
