import 'package:flutter/material.dart';
import '../../../core/models/app_error.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final bool showDetails;

  const ErrorDisplayWidget({
    super.key,
    required this.error,
    this.onRetry,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            Icon(_getErrorIcon(), size: 64, color: _getErrorColor()),
            const SizedBox(height: 16),

            // Error Title
            Text(
              _getErrorTitle(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: _getErrorColor(),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Error Message
            Text(
              error.userFriendlyMessage,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),

            // Error Details (if enabled)
            if (showDetails && error.code != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Error Code: ${error.code}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (error.canRetry && onRetry != null) ...[
                  ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],

                // Additional action based on error type
                if (error.isNetworkError)
                  OutlinedButton.icon(
                    onPressed: () => _showNetworkTips(context),
                    icon: const Icon(Icons.help_outline),
                    label: const Text('Help'),
                  )
                else if (error.isServerError)
                  OutlinedButton.icon(
                    onPressed: () => _showServerErrorInfo(context),
                    icon: const Icon(Icons.info_outline),
                    label: const Text('Info'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    switch (error.type) {
      case ErrorType.network:
      case ErrorType.noInternet:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.cloud_off;
      case ErrorType.timeout:
        return Icons.access_time;
      case ErrorType.unauthorized:
        return Icons.lock_outline;
      case ErrorType.notFound:
        return Icons.search_off;
      case ErrorType.apiResponse:
        return Icons.error_outline;
      default:
        return Icons.error_outline;
    }
  }

  Color _getErrorColor() {
    switch (error.type) {
      case ErrorType.network:
      case ErrorType.noInternet:
        return Colors.orange;
      case ErrorType.server:
        return Colors.red;
      case ErrorType.timeout:
        return Colors.amber;
      case ErrorType.unauthorized:
        return Colors.purple;
      case ErrorType.notFound:
        return Colors.blue;
      case ErrorType.apiResponse:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getErrorTitle() {
    switch (error.type) {
      case ErrorType.network:
      case ErrorType.noInternet:
        return 'Connection Problem';
      case ErrorType.server:
        return 'Server Error';
      case ErrorType.timeout:
        return 'Request Timeout';
      case ErrorType.unauthorized:
        return 'Session Expired';
      case ErrorType.notFound:
        return 'Not Found';
      case ErrorType.apiResponse:
        return 'Service Error';
      default:
        return 'Something Went Wrong';
    }
  }

  void _showNetworkTips(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Tips'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Check your internet connection'),
            Text('• Try switching between WiFi and mobile data'),
            Text('• Make sure you\'re not in airplane mode'),
            Text('• Restart your router if using WiFi'),
            Text('• Contact your network provider if issues persist'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showServerErrorInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Server Information'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('The server is currently experiencing issues.'),
            SizedBox(height: 8),
            Text('This is usually temporary and will be resolved soon.'),
            SizedBox(height: 8),
            Text('You can:'),
            Text('• Try again in a few minutes'),
            Text('• Check our status page for updates'),
            Text('• Contact support if the issue persists'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
