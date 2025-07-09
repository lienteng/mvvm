import '../../../core/constants/api_constants.dart';
import '../../../core/models/api_response.dart';
import '../../../core/services/api_service.dart';
import '../models/report_problem.dart';

class ReportProblemRepository {
  final ApiService _apiService;

  ReportProblemRepository(this._apiService);

  Future<ApiResponse<ReportProblem>> getReportProblems({
    int page = 1,
    int perPage = 8,
    int? employeeId,
  }) async {
    final queryParameters = <String, dynamic>{
      'limit': perPage,
      'page': page,
      'frDate': '',
      'toDate': '',
      'empId': 36,
    };

    return await _apiService.get<ReportProblem>(
      ApiConstants.reportProblems,
      queryParameters: queryParameters,
      fromJson: ReportProblem.fromJson,
    );
  }

  Future<ApiResponse<ReportProblem>> createReportProblem({
    required int scheduleDetailId,
    required String description,
    required String date,
  }) async {
    final data = {
      'schedule_detail_id': scheduleDetailId,
      'description': description,
      'date': date,
    };

    return await _apiService.post<ReportProblem>(
      ApiConstants.reportProblems,
      data: data,
      fromJson: ReportProblem.fromJson,
    );
  }
}
