import 'package:flutter/material.dart';

class AttendanceButtons extends StatelessWidget {
  final bool canCheckIn;
  final bool canCheckOut;
  final bool isSubmitting;
  final bool isBiometricAvailable;
  final bool canSubmit;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;

  const AttendanceButtons({
    super.key,
    required this.canCheckIn,
    required this.canCheckOut,
    required this.isSubmitting,
    required this.isBiometricAvailable,
    required this.canSubmit,
    required this.onCheckIn,
    required this.onCheckOut,
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
                Icon(Icons.fingerprint, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Biometric Authentication',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Biometric status warning
            if (!isBiometricAvailable) ...[
              Container(
                padding: const EdgeInsets.all(12),
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
                      child: Text(
                        'Biometric authentication is not available. Please check your device settings.',
                        style: TextStyle(color: Colors.orange.shade700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Check In/Out Buttons
            Row(
              children: [
                // Check In Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        canSubmit &&
                            canCheckIn &&
                            isBiometricAvailable &&
                            !isSubmitting
                        ? onCheckIn
                        : null,
                    icon: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.login),
                    label: Text(
                      isSubmitting ? 'Processing...' : 'Check In',
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Check Out Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        canSubmit &&
                            canCheckOut &&
                            isBiometricAvailable &&
                            !isSubmitting
                        ? onCheckOut
                        : null,
                    icon: isSubmitting
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.logout),
                    label: Text(
                      isSubmitting ? 'Processing...' : 'Check Out',
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Instructions
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(color: Colors.blue.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Instructions:',
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Select your name from the dropdown above\n'
                    '2. Tap Check In or Check Out button\n'
                    '3. Complete biometric authentication\n'
                    '4. Your attendance will be recorded',
                    style: TextStyle(color: Colors.blue.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Status indicators
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatusIndicator(
                  'Employee Selected',
                  canSubmit,
                  canSubmit ? Icons.check_circle : Icons.radio_button_unchecked,
                ),
                const SizedBox(width: 16),
                _buildStatusIndicator(
                  'Biometric Ready',
                  isBiometricAvailable,
                  isBiometricAvailable
                      ? Icons.fingerprint
                      : Icons.fingerprint_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isActive, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: isActive ? Colors.green : Colors.grey),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
