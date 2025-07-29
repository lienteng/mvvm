import 'dart:convert';
import '../../../core/constants/api_constants.dart';
import '../../../core/models/api_response.dart';
import '../../../core/models/app_error.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/storage_service.dart';
import '../models/attendance_record.dart';
import '../models/employee.dart';

class AttendanceRepository {
  final ApiService _apiService;
  final StorageService _storageService;

  static const String _attendanceRecordsKey = 'attendance_records';
  static const String _employeesKey = 'employees_list';

  AttendanceRepository(this._apiService, this._storageService);

  // Get employees list
  Future<List<Employee>> getEmployees() async {
    try {
      // Try to get from API first
      final response = await _apiService.get<Employee>(
        ApiConstants.employees,
        fromJson: Employee.fromJson,
      );

      // Cache the result
      await _cacheEmployees(response.data);
      return response.data;
    } on AppError catch (e) {
      print('AttendanceRepository: Error fetching employees from API: $e');
      // Fallback to cached data
      return await _getCachedEmployees();
    } catch (e) {
      print('AttendanceRepository: Unexpected error fetching employees: $e');
      return await _getCachedEmployees();
    }
  }

  // Submit attendance record
  Future<bool> submitAttendance(AttendanceRecord record) async {
    try {
      // Try to submit to API
      final response = await _apiService.post<AttendanceRecord>(
        ApiConstants.attendance,
        data: record.toJson(),
        fromJson: AttendanceRecord.fromJson,
      );

      // Mark as synced and save locally
      final syncedRecord = record.copyWith(isSync: true);
      await _saveAttendanceRecord(syncedRecord);

      print('AttendanceRepository: Attendance submitted successfully');
      return true;
    } on AppError catch (e) {
      print('AttendanceRepository: Error submitting attendance: $e');

      // Save locally as unsynced
      final unsyncedRecord = record.copyWith(isSync: false);
      await _saveAttendanceRecord(unsyncedRecord);

      // Return true because we saved locally
      return true;
    } catch (e) {
      print('AttendanceRepository: Unexpected error submitting attendance: $e');

      // Save locally as unsynced
      final unsyncedRecord = record.copyWith(isSync: false);
      await _saveAttendanceRecord(unsyncedRecord);

      return true;
    }
  }

  // Get attendance history
  Future<List<AttendanceRecord>> getAttendanceHistory({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Try to get from API first
      final queryParams = <String, dynamic>{};
      if (userId != null) queryParams['user_id'] = userId;
      if (startDate != null)
        queryParams['start_date'] = startDate.toIso8601String();
      if (endDate != null) queryParams['end_date'] = endDate.toIso8601String();

      final response = await _apiService.get<AttendanceRecord>(
        ApiConstants.attendanceHistory,
        queryParameters: queryParams,
        fromJson: AttendanceRecord.fromJson,
      );

      // Merge with local records
      final localRecords = await _getLocalAttendanceRecords();
      final allRecords = [...response.data, ...localRecords];

      // Remove duplicates and sort by timestamp
      final uniqueRecords = _removeDuplicateRecords(allRecords);
      uniqueRecords.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return uniqueRecords;
    } on AppError catch (e) {
      print('AttendanceRepository: Error fetching attendance history: $e');
      // Fallback to local records only
      return await _getLocalAttendanceRecords();
    } catch (e) {
      print(
        'AttendanceRepository: Unexpected error fetching attendance history: $e',
      );
      return await _getLocalAttendanceRecords();
    }
  }

  // Sync unsynced records
  Future<int> syncUnsyncedRecords() async {
    final localRecords = await _getLocalAttendanceRecords();
    final unsyncedRecords = localRecords
        .where((record) => !record.isSync)
        .toList();

    int syncedCount = 0;

    for (final record in unsyncedRecords) {
      try {
        await _apiService.post<AttendanceRecord>(
          ApiConstants.attendance,
          data: record.toJson(),
          fromJson: AttendanceRecord.fromJson,
        );

        // Mark as synced
        final syncedRecord = record.copyWith(isSync: true);
        await _updateAttendanceRecord(syncedRecord);
        syncedCount++;
      } catch (e) {
        print('AttendanceRepository: Failed to sync record ${record.id}: $e');
      }
    }

    return syncedCount;
  }

  // Private methods for local storage
  Future<void> _saveAttendanceRecord(AttendanceRecord record) async {
    final records = await _getLocalAttendanceRecords();

    // Remove existing record with same ID if exists
    records.removeWhere((r) => r.id == record.id);

    // Add new record
    records.add(record);

    // Save to storage
    final recordsJson = records.map((r) => r.toJson()).toList();
    await _storageService.setString(
      _attendanceRecordsKey,
      jsonEncode(recordsJson),
    );
  }

  Future<void> _updateAttendanceRecord(AttendanceRecord record) async {
    final records = await _getLocalAttendanceRecords();

    // Find and update the record
    final index = records.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      records[index] = record;

      // Save to storage
      final recordsJson = records.map((r) => r.toJson()).toList();
      await _storageService.setString(
        _attendanceRecordsKey,
        jsonEncode(recordsJson),
      );
    }
  }

  Future<List<AttendanceRecord>> _getLocalAttendanceRecords() async {
    try {
      final recordsString = _storageService.getString(_attendanceRecordsKey);
      if (recordsString == null) return [];

      final recordsJson = jsonDecode(recordsString) as List;
      return recordsJson
          .map((json) => AttendanceRecord.fromJson(json))
          .toList();
    } catch (e) {
      print('AttendanceRepository: Error getting local attendance records: $e');
      return [];
    }
  }

  Future<void> _cacheEmployees(List<Employee> employees) async {
    try {
      final employeesJson = employees.map((e) => e.toJson()).toList();
      await _storageService.setString(_employeesKey, jsonEncode(employeesJson));
    } catch (e) {
      print('AttendanceRepository: Error caching employees: $e');
    }
  }

  Future<List<Employee>> _getCachedEmployees() async {
    try {
      final employeesString = _storageService.getString(_employeesKey);
      if (employeesString == null) return [];

      final employeesJson = jsonDecode(employeesString) as List;
      return employeesJson.map((json) => Employee.fromJson(json)).toList();
    } catch (e) {
      print('AttendanceRepository: Error getting cached employees: $e');
      return [];
    }
  }

  List<AttendanceRecord> _removeDuplicateRecords(
    List<AttendanceRecord> records,
  ) {
    final Map<String, AttendanceRecord> uniqueRecords = {};

    for (final record in records) {
      // Use ID as key, prefer synced records over unsynced ones
      if (!uniqueRecords.containsKey(record.id) ||
          (record.isSync && !uniqueRecords[record.id]!.isSync)) {
        uniqueRecords[record.id] = record;
      }
    }

    return uniqueRecords.values.toList();
  }
}
