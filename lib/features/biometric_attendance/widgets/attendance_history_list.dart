import 'package:flutter/material.dart';
import '../models/attendance_record.dart';

class AttendanceHistoryList extends StatelessWidget {
  final List<AttendanceRecord> attendanceHistory;
  final String? selectedEmployeeId;

  const AttendanceHistoryList({
    super.key,
    required this.attendanceHistory,
    this.selectedEmployeeId,
  });

  @override
  Widget build(BuildContext context) {
    // Filter records for selected employee if specified
    final filteredHistory = selectedEmployeeId != null
        ? attendanceHistory
              .where((record) => record.userId == selectedEmployeeId)
              .toList()
        : attendanceHistory;

    if (filteredHistory.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(Icons.history, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Attendance History',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                selectedEmployeeId != null
                    ? 'No records found for selected employee'
                    : 'Attendance records will appear here',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.history, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  'Attendance Records (${filteredHistory.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),

          // List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredHistory.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final record = filteredHistory[index];
              return _AttendanceRecordTile(record: record);
            },
          ),
        ],
      ),
    );
  }
}

class _AttendanceRecordTile extends StatelessWidget {
  final AttendanceRecord record;

  const _AttendanceRecordTile({required this.record});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: record.isCheckIn
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          record.isCheckIn ? Icons.login : Icons.logout,
          color: record.isCheckIn ? Colors.green : Colors.red,
        ),
      ),
      title: Row(
        children: [
          Text(
            record.userName,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: record.isCheckIn ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              record.isCheckIn ? 'CHECK IN' : 'CHECK OUT',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            record.formattedDateTime,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.smartphone, size: 12, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Device: ${record.deviceId}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            record.formattedTime,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: record.isCheckIn ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!record.isSync) ...[
                Icon(Icons.sync_problem, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
              ],
              Icon(
                record.isSync ? Icons.cloud_done : Icons.cloud_off,
                size: 16,
                color: record.isSync ? Colors.green : Colors.orange,
              ),
            ],
          ),
        ],
      ),
      onTap: () => _showRecordDetails(context, record),
    );
  }

  void _showRecordDetails(BuildContext context, AttendanceRecord record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Attendance Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Employee', record.userName),
            _DetailRow('Action', record.action),
            _DetailRow('Date & Time', record.formattedDateTime),
            _DetailRow('Device ID', record.deviceId),
            _DetailRow('Sync Status', record.isSync ? 'Synced' : 'Pending'),
            if (record.location != null)
              _DetailRow('Location', record.location!),
          ],
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
