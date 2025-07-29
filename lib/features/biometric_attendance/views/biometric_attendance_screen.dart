import 'package:flutter/material.dart';
import 'package:mvvm/features/biometric_attendance/widgets/attendance_buttons.dart';
import 'package:mvvm/features/biometric_attendance/widgets/attendance_history_list.dart';
import 'package:mvvm/features/biometric_attendance/widgets/biometric_status_card.dart';
import 'package:mvvm/features/biometric_attendance/widgets/employee_selector.dart';
import 'package:provider/provider.dart';
import '../viewmodels/attendance_viewmodel.dart';

class BiometricAttendanceScreen extends StatefulWidget {
  const BiometricAttendanceScreen({super.key});

  @override
  State<BiometricAttendanceScreen> createState() =>
      _BiometricAttendanceScreenState();
}

class _BiometricAttendanceScreenState extends State<BiometricAttendanceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AttendanceViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Attendance'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Consumer<AttendanceViewModel>(
            builder: (context, viewModel, child) {
              final unsyncedCount = viewModel.unsyncedRecordsCount;
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.sync),
                    onPressed: viewModel.hasData
                        ? viewModel.syncUnsyncedRecords
                        : null,
                    tooltip: 'Sync Records',
                  ),
                  if (unsyncedCount > 0)
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
                          unsyncedCount > 99 ? '99+' : unsyncedCount.toString(),
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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<AttendanceViewModel>().refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Consumer<AttendanceViewModel>(
        builder: (context, viewModel, child) {
          // Show loading for initial load
          if (viewModel.isLoading && !viewModel.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading attendance system...'),
                ],
              ),
            );
          }

          // Show error if no data and has error
          if (viewModel.hasError && !viewModel.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load attendance system',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    viewModel.errorMessage ?? 'Unknown error',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.initialize(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: viewModel.refresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Success/Error Messages
                  if (viewModel.successMessage != null)
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
                              viewModel.successMessage!,
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: viewModel.clearMessages,
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),

                  if (viewModel.error != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, color: Colors.red.shade700),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              viewModel.error!.userFriendlyMessage,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: viewModel.clearMessages,
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ),

                  // Biometric Status Card
                  BiometricStatusCard(
                    status: viewModel.biometricStatus,
                    availableBiometrics: viewModel.availableBiometrics,
                  ),
                  const SizedBox(height: 24),

                  // Employee Selector
                  Text(
                    'Step 1: Select Employee',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  EmployeeSelector(
                    employees: viewModel.employees,
                    selectedEmployee: viewModel.selectedEmployee,
                    onEmployeeSelected: viewModel.selectEmployee,
                  ),
                  const SizedBox(height: 24),

                  // Attendance Buttons
                  Text(
                    'Step 2: Biometric Authentication & Check In/Out',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AttendanceButtons(
                    canCheckIn: viewModel.canCheckIn,
                    canCheckOut: viewModel.canCheckOut,
                    isSubmitting: viewModel.isSubmittingAttendance,
                    isBiometricAvailable: viewModel.isBiometricAvailable,
                    canSubmit: viewModel.canSubmitAttendance,
                    onCheckIn: () => _handleCheckIn(context),
                    onCheckOut: () => _handleCheckOut(context),
                  ),
                  const SizedBox(height: 24),

                  // Today's Attendance Summary
                  if (viewModel.selectedEmployee != null) ...[
                    _buildTodayAttendanceSummary(context, viewModel),
                    const SizedBox(height: 24),
                  ],

                  // Attendance History
                  Text(
                    'Step 3: Attendance History',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AttendanceHistoryList(
                    attendanceHistory: viewModel.attendanceHistory,
                    selectedEmployeeId: viewModel.selectedEmployee?.id,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTodayAttendanceSummary(
    BuildContext context,
    AttendanceViewModel viewModel,
  ) {
    final todayAttendance = viewModel.todayAttendance;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.today, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Today\'s Attendance - ${viewModel.selectedEmployee!.name}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (todayAttendance.isEmpty) ...[
              Text(
                'No attendance records for today',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ] else ...[
              ...todayAttendance.map(
                (record) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: record.isCheckIn ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          record.isCheckIn ? 'IN' : 'OUT',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        record.formattedTime,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      if (!record.isSync)
                        Icon(
                          Icons.sync_problem,
                          size: 16,
                          color: Colors.orange,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _handleCheckIn(BuildContext context) async {
    final success = await context.read<AttendanceViewModel>().checkIn();

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
    final success = await context.read<AttendanceViewModel>().checkOut();

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-out successful!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
