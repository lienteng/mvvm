import 'package:flutter/foundation.dart';
import '../../../core/utils/app_res_code.dart';
import '../models/report_problem.dart';
import '../repositories/report_problem_repository.dart';

class ReportProblemViewModel extends ChangeNotifier {
  final ReportProblemRepository _repository;

  ReportProblemViewModel(this._repository);

  // State
  List<ReportProblem> _reportProblems = [];
  bool _isLoading = false;
  bool _isRefreshing = false; // Add this to track refresh state
  String? _errorMessage;
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasMoreData = true;

  // Getters
  List<ReportProblem> get reportProblems => _reportProblems;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing; // Add this getter
  String? get errorMessage => _errorMessage;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get hasMoreData => _hasMoreData;

  // Methods
  Future<void> loadReportProblems({
    bool refresh = false,
    int? employeeId,
  }) async {
    if (refresh) {
      _currentPage = 1;
      _hasMoreData = true;
      if (_reportProblems.isNotEmpty) {
        _setRefreshing(true);
      }
    }

    if (_isLoading || (!refresh && !_hasMoreData)) return;

    _setLoading(true);
    _clearError();

    try {
      final response = await _repository.getReportProblems(
        page: _currentPage,
        employeeId: employeeId,
      );
      if (AppResCode.isSuccess(response.resCode)) {
        if (refresh) {
          // Only replace data after successful response
          _reportProblems = response.data;
        } else {
          _reportProblems.addAll(response.data);
        }
        _currentPage = response.currentPage;
        _totalPages = response.totalPage;
        _hasMoreData = _currentPage < _totalPages;

        if (_hasMoreData) {
          _currentPage++;
        }
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
      if (refresh && _reportProblems.isNotEmpty) {
        _setRefreshing(false); // Clear refreshing state
      }
    }
  }

  Future<void> createReportProblem({
    required int scheduleDetailId,
    required String description,
    required String date,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _repository.createReportProblem(
        scheduleDetailId: scheduleDetailId,
        description: description,
        date: date,
      );

      if (AppResCode.isSuccess(response.resCode)) {
        // Refresh the list after creating
        await loadReportProblems(refresh: true);
      } else {
        _setError(response.message);
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setRefreshing(bool refreshing) {
    // Add this method
    _isRefreshing = refreshing;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
