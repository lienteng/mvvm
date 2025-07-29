import 'package:flutter/material.dart';
import '../services/biometric_service.dart';

class BiometricStatusCard extends StatelessWidget {
  final BiometricStatus status;
  final String availableBiometrics;

  const BiometricStatusCard({
    super.key,
    required this.status,
    required this.availableBiometrics,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getStatusIcon(), color: _getStatusColor()),
                const SizedBox(width: 8),
                Text(
                  'Biometric Status',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.1),
                border: Border.all(color: _getStatusColor().withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getStatusIcon(),
                        color: _getStatusColor(),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _getStatusTitle(),
                        style: TextStyle(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getStatusMessage(),
                    style: TextStyle(color: _getStatusColor(), fontSize: 12),
                  ),
                  if (status == BiometricStatus.available) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Available: $availableBiometrics',
                      style: TextStyle(
                        color: _getStatusColor(),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Action button for setup if needed
            if (status == BiometricStatus.notEnrolled ||
                status == BiometricStatus.notAvailable) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _showSetupInstructions(context),
                  icon: const Icon(Icons.settings, size: 16),
                  label: const Text('Setup Instructions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (status) {
      case BiometricStatus.available:
        return Icons.check_circle;
      case BiometricStatus.notAvailable:
        return Icons.error;
      case BiometricStatus.notEnrolled:
        return Icons.warning;
      case BiometricStatus.unknown:
        return Icons.help;
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case BiometricStatus.available:
        return Colors.green;
      case BiometricStatus.notAvailable:
        return Colors.red;
      case BiometricStatus.notEnrolled:
        return Colors.orange;
      case BiometricStatus.unknown:
        return Colors.grey;
    }
  }

  String _getStatusTitle() {
    switch (status) {
      case BiometricStatus.available:
        return 'Ready';
      case BiometricStatus.notAvailable:
        return 'Not Available';
      case BiometricStatus.notEnrolled:
        return 'Not Set Up';
      case BiometricStatus.unknown:
        return 'Unknown';
    }
  }

  String _getStatusMessage() {
    switch (status) {
      case BiometricStatus.available:
        return 'Biometric authentication is ready to use';
      case BiometricStatus.notAvailable:
        return 'This device does not support biometric authentication';
      case BiometricStatus.notEnrolled:
        return 'Please set up fingerprint or face recognition in device settings';
      case BiometricStatus.unknown:
        return 'Unable to determine biometric status';
    }
  }

  void _showSetupInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Biometric Setup'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To use biometric authentication:'),
            const SizedBox(height: 8),
            const Text('Android:'),
            const Text('• Go to Settings > Security > Fingerprint/Face'),
            const Text('• Follow the setup instructions'),
            const SizedBox(height: 8),
            const Text('iOS:'),
            const Text('• Go to Settings > Touch ID & Passcode'),
            const Text('• Or Settings > Face ID & Passcode'),
            const Text('• Follow the setup instructions'),
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
