import 'package:flutter/foundation.dart';
import '../models/attendance_record.dart';
import '../models/employee.dart';
import '../repositories/attendance_repository.dart';
import '../services/biometric_service.dart';
import '../services/device_service.dart';
import '../../../core/models/app_error.dart';

enum AttendanceLoadingState { initial, loading, loaded, error }

class AttendanceViewModel extends ChangeNotifier {
  final AttendanceRepository _attendanceRepository;
  final BiometricService _biometricService;

  AttendanceViewModel(this._attendanceRepository, this._biometricService);

  // State
  List<Employee> _employees = [];
  Employee? _selectedEmployee;
  List<AttendanceRecord> _attendanceHistory = [];
  AttendanceLoadingState _loadingState = AttendanceLoadingState.initial;
  AppError? _error;
  String? _successMessage;
  bool _isSubmittingAttendance = false;
  BiometricStatus _biometricStatus = BiometricStatus.unknown;
  String _availableBiometrics = '';

  // Getters
  List<Employee> get employees => _employees;
  Employee? get selectedEmployee => _selectedEmployee;
  List<AttendanceRecord> get attendanceHistory => _attendanceHistory;
  AttendanceLoadingState get loadingState => _loadingState;
  AppError? get error => _error;
  String? get errorMessage => _error?.userFriendlyMessage;
  String? get successMessage => _successMessage;
  bool get isSubmittingAttendance => _isSubmittingAttendance;
  BiometricStatus get biometricStatus => _biometricStatus;
  String get availableBiometrics => _availableBiometrics;

  bool get isLoading => _loadingState == AttendanceLoadingState.loading;
  bool get hasError => _loadingState == AttendanceLoadingState.error;
  bool get hasData => _loadingState == AttendanceLoadingState.loaded;
  bool get canSubmitAttendance =>
      _selectedEmployee != null && !_isSubmittingAttendance;
  bool get isBiometricAvailable =>
      _biometricStatus == BiometricStatus.available;

  // Get today's attendance for selected employee
  List<AttendanceRecord> get todayAttendance {
    if (_selectedEmployee == null) return [];

    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _attendanceHistory.where((record) {
      return record.userId == _selectedEmployee!.id &&
          record.timestamp.isAfter(startOfDay) &&
          record.timestamp.isBefore(endOfDay);
    }).toList();
  }

  // Check if employee can check in/out
  bool get canCheckIn {
    final todayRecords = todayAttendance;
    if (todayRecords.isEmpty) return true;

    // Can check in if last record was check out
    final lastRecord = todayRecords.first;
    return lastRecord.isCheckOut;
  }

  bool get canCheckOut {
    final todayRecords = todayAttendance;
    if (todayRecords.isEmpty) return false;

    // Can check out if last record was check in
    final lastRecord = todayRecords.first;
    return lastRecord.isCheckIn;
  }

  // Initialize
  Future<void> initialize() async {
    print('AttendanceViewModel: Initializing');
    _setLoadingState(AttendanceLoadingState.loading);
    _clearError();

    try {
      // Check biometric status
      await _checkBiometricStatus();

      // Load employees
      await _loadEmployees();

      // Load attendance history
      await _loadAttendanceHistory();

      _setLoadingState(AttendanceLoadingState.loaded);
      print('AttendanceViewModel: Initialization completed');
    } on AppError catch (e) {
      print('AttendanceViewModel: AppError during initialization: $e');
      _setError(e);
      _setLoadingState(AttendanceLoadingState.error);
    } catch (e) {
      print('AttendanceViewModel: Unexpected error during initialization: $e');
      _setError(AppError.unknown('Failed to initialize', originalError: e));
      _setLoadingState(AttendanceLoadingState.error);
    }
  }

  // Check biometric status
  Future<void> _checkBiometricStatus() async {
    try {
      print('AttendanceViewModel: Checking biometric status');
      _biometricStatus = await _biometricService.getBiometricStatus();
      _availableBiometrics = await _biometricService
          .getAvailableBiometricNames();
      print('AttendanceViewModel: Biometric status: $_biometricStatus');
      print('AttendanceViewModel: Available biometrics: $_availableBiometrics');
      notifyListeners();
    } catch (e) {
      print('AttendanceViewModel: Error checking biometric status: $e');
      _biometricStatus = BiometricStatus.unknown;
      _availableBiometrics = 'Unknown';
    }
  }

  // Load employees
  // Future<void> _loadEmployees() async {
  //   try {
  //     _employees = await _attendanceRepository.getEmployees();
  //     print('AttendanceViewModel: Loaded ${_employees.length} employees');
  //   } catch (e) {
  //     print('AttendanceViewModel: Error loading employees: $e');
  //     _employees = [];
  //   }
  // }
  Future<void> _loadEmployees() async {
    try {
      _employees = [
        Employee(
          id: '1',
          name: 'John Doe',
          empNo: 'EMP001',
          email: 'john.doe@example.com',
          department: 'Security',
        ),
        Employee(
          id: '2',
          name: 'Jane Smith',
          empNo: 'EMP002',
          email: 'jane.smith@example.com',
          department: 'Reception',
        ),
        Employee(
          id: '3',
          name: 'Bob Johnson',
          empNo: 'EMP003',
          email: 'bob.johnson@example.com',
          department: 'Maintenance',
        ),
      ];
      print('Loaded ${_employees.length} employees manually');
    } catch (e) {
      _employees = [];
    }
  }

  // Load attendance history
  Future<void> _loadAttendanceHistory() async {
    try {
      _attendanceHistory = await _attendanceRepository.getAttendanceHistory();
      print(
        'AttendanceViewModel: Loaded ${_attendanceHistory.length} attendance records',
      );
    } catch (e) {
      print('AttendanceViewModel: Error loading attendance history: $e');
      _attendanceHistory = [];
    }
  }

  // Select employee
  void selectEmployee(Employee employee) {
    _selectedEmployee = employee;
    print('AttendanceViewModel: Selected employee: ${employee.name}');
    notifyListeners();
  }

  // Check in with biometric authentication
  Future<bool> checkIn() async {
    return await _performAttendanceAction('CHECK_IN');
  }

  // Check out with biometric authentication
  Future<bool> checkOut() async {
    return await _performAttendanceAction('CHECK_OUT');
  }

  // Perform attendance action (check in/out)
  Future<bool> _performAttendanceAction(String action) async {
    if (_selectedEmployee == null) {
      _setError(AppError.unknown('Please select an employee first'));
      return false;
    }

    if (_isSubmittingAttendance) return false;

    print(
      'AttendanceViewModel: Starting $action process for ${_selectedEmployee!.name}',
    );
    _setSubmittingAttendance(true);
    _clearMessages();

    if (_biometricStatus == BiometricStatus.notAvailable) {
      _setError(AppError.unknown('Biometric authentication is not available'));
      return false;
    }
    print(
      'AttendanceViewModel: Biometric status is available: $_biometricStatus',
    );

    try {
      // Step 1: Authenticate with biometrics
      final authResult = await _biometricService.authenticate(
        reason: 'Authenticate to $action',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      if (!authResult.success) {
        _setError(
          AppError.unknown(
            authResult.errorMessage ?? 'Biometric authentication failed',
          ),
        );
        return false;
      }

      // Step 2: Get device information
      final deviceId = await DeviceService.getDeviceId();

      // Step 3: Create attendance record
      final attendanceRecord = AttendanceRecord(
        id: '${_selectedEmployee!.id}_${DateTime.now().millisecondsSinceEpoch}',
        userId: _selectedEmployee!.id,
        userName: _selectedEmployee!.name,
        action: action,
        timestamp: DateTime.now(),
        deviceId: deviceId,
        location: null, // You can add location if needed
        isSync: false,
      );

      // Step 4: Submit attendance
      final success = await _attendanceRepository.submitAttendance(
        attendanceRecord,
      );

      if (success) {
        _setSuccess('$action successful!');

        // Refresh attendance history
        await _loadAttendanceHistory();

        print('AttendanceViewModel: $action completed successfully');
        return true;
      } else {
        _setError(AppError.unknown('Failed to submit $action'));
        return false;
      }
    } on AppError catch (e) {
      print('AttendanceViewModel: AppError during $action: $e');
      _setError(e);
      return false;
    } catch (e) {
      print('AttendanceViewModel: Unexpected error during $action: $e');
      _setError(AppError.unknown('$action failed', originalError: e));
      return false;
    } finally {
      _setSubmittingAttendance(false);
    }
  }

  // Refresh data
  Future<void> refresh() async {
    print('AttendanceViewModel: Refreshing data');

    try {
      // Reload employees and attendance history
      await Future.wait([_loadEmployees(), _loadAttendanceHistory()]);

      _setSuccess('Data refreshed successfully');
      print('AttendanceViewModel: Data refreshed successfully');
    } on AppError catch (e) {
      print('AttendanceViewModel: AppError during refresh: $e');
      _setError(e);
    } catch (e) {
      print('AttendanceViewModel: Unexpected error during refresh: $e');
      _setError(AppError.unknown('Failed to refresh data', originalError: e));
    }
  }

  // Sync unsynced records
  Future<void> syncUnsyncedRecords() async {
    try {
      final syncedCount = await _attendanceRepository.syncUnsyncedRecords();

      if (syncedCount > 0) {
        _setSuccess('Synced $syncedCount records successfully');
        await _loadAttendanceHistory();
      } else {
        _setSuccess('All records are already synced');
      }
    } catch (e) {
      print('AttendanceViewModel: Error syncing records: $e');
      _setError(AppError.unknown('Failed to sync records', originalError: e));
    }
  }

  // Get unsynced records count
  int get unsyncedRecordsCount {
    return _attendanceHistory.where((record) => !record.isSync).length;
  }

  // Helper methods
  void _setLoadingState(AttendanceLoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  void _setSubmittingAttendance(bool submitting) {
    if (_isSubmittingAttendance == submitting) return;
    print('AttendanceViewModel: Setting submitting attendance to $submitting');
    _isSubmittingAttendance = submitting;
    notifyListeners();
  }

  void _setError(AppError error) {
    _error = error;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccess(String success) {
    _successMessage = success;
    _error = null;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }

  void _clearMessages() {
    _error = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearMessages() {
    _clearMessages();
  }

  // Get error details for debugging
  String getErrorDetails() {
    if (_error == null) return 'No error';

    return '''
Error Type: ${_error!.type}
Message: ${_error!.message}
Code: ${_error!.code ?? 'N/A'}
Status Code: ${_error!.statusCode ?? 'N/A'}
Can Retry: ${_error!.canRetry}
User Message: ${_error!.userFriendlyMessage}
''';
  }
}
