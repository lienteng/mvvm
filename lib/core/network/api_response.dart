// import 'package:super_thanjai/core/constants/app_res_code.dart';
// import 'package:super_thanjai/features/auth/data/models/user_model.dart';

// class ApiResponse<T> {
//   final String resCode;
//   final String message;
//   final T? data;
//   final Map<String, dynamic>? summary;

//   ApiResponse({
//     required this.resCode,
//     required this.message,
//     this.data,
//     this.summary,
//   });

//   factory ApiResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic)? fromJsonT,
//   ) {
//     return ApiResponse<T>(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       data: json['data'] != null && fromJsonT != null
//           ? fromJsonT(json['data'])
//           : json['data'],
//       summary: json['summary'] as Map<String, dynamic>?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'resCode': resCode,
//       'message': message,
//       'data': data,
//       'summary': summary,
//     };
//   }

//   // Helper methods
//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasData => data != null;
//   bool get hasSummary => summary != null && summary!.isNotEmpty;

//   String get statusMessage => AppResCode.resCode(resCode);
//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// class ApiLoginResponse<T> {
//   final String resCode;
//   final String message;
//   final T? data;
//   final String? token;
//   final String? refreshToken;
//   final String? expiresIn;

//   ApiLoginResponse({
//     required this.resCode,
//     required this.message,
//     this.data,
//     this.token,
//     this.refreshToken,
//     this.expiresIn,
//   });

//   factory ApiLoginResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic)? fromJsonT,
//   ) {
//     return ApiLoginResponse<T>(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       data: json['data'] != null && fromJsonT != null
//           ? fromJsonT(json['data'])
//           : null,
//       token: json['token'] as String?,
//       refreshToken: json['refreshToken'] as String?,
//       expiresIn: json['expiresIn'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'resCode': resCode,
//       'message': message,
//       'data': data is UserModel ? (data as UserModel).toJson() : data,
//       'token': token,
//       'refreshToken': refreshToken,
//       'expiresIn': expiresIn,
//     };
//   }

//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasData => data != null;
//   bool get isObject => data is Map<String, dynamic>;
//   bool get isList => data is List<dynamic>;

//   String get statusMessage => AppResCode.resCode(resCode);
//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// // Enhanced paginated response for list data with flexible pagination info
// class PaginatedApiResponse<T> {
//   final String resCode;
//   final String message;
//   final List<T> data;
//   final Map<String, dynamic>? summary;
//   final PaginationMeta? pagination;

//   PaginatedApiResponse({
//     required this.resCode,
//     required this.message,
//     required this.data,
//     this.summary,
//     this.pagination,
//   });

//   factory PaginatedApiResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(Map<String, dynamic>) fromJsonT,
//   ) {
//     final dataList = json['data'] as List? ?? [];
//     final summaryData = json['summary'] as Map<String, dynamic>?;

//     // Create pagination meta from root level or summary
//     PaginationMeta? paginationMeta;
//     if (json.containsKey('per_page') || json.containsKey('current_page')) {
//       // Pagination info at root level (your new format)
//       paginationMeta = PaginationMeta.fromJson(json);
//     } else if (summaryData != null) {
//       // Pagination info in summary (old format)
//       paginationMeta = PaginationMeta.fromJson(summaryData);
//     }

//     return PaginatedApiResponse<T>(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       data: dataList
//           .map((item) => fromJsonT(item as Map<String, dynamic>))
//           .toList(),
//       summary: summaryData,
//       pagination: paginationMeta,
//     );
//   }

//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasData => data.isNotEmpty;
//   bool get hasPagination => pagination != null;

//   String get statusMessage => AppResCode.resCode(resCode);
//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// class PaginationMeta {
//   final int? currentPage;
//   final int? lastPage;
//   final int? totalPage;
//   final int? perPage;
//   final int? total;
//   final int? totalItem;
//   final bool? hasNextPage;
//   final bool? hasPreviousPage;

//   PaginationMeta({
//     this.currentPage,
//     this.lastPage,
//     this.totalPage,
//     this.perPage,
//     this.total,
//     this.totalItem,
//     this.hasNextPage,
//     this.hasPreviousPage,
//   });

//   factory PaginationMeta.fromJson(Map<String, dynamic> json) {
//     final currentPage = json['current_page'] ?? json['currentPage'];
//     final totalPage =
//         json['total_page'] ??
//         json['totalPage'] ??
//         json['last_page'] ??
//         json['lastPage'];
//     final perPage = json['per_page'] ?? json['perPage'];
//     final totalItem = json['total_item'] ?? json['totalItem'] ?? json['total'];

//     return PaginationMeta(
//       currentPage: currentPage,
//       lastPage: json['last_page'] ?? json['lastPage'],
//       totalPage: totalPage,
//       perPage: perPage,
//       total: json['total'],
//       totalItem: totalItem,
//       hasNextPage: currentPage != null && totalPage != null
//           ? currentPage < totalPage
//           : null,
//       hasPreviousPage: currentPage != null ? currentPage > 1 : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'current_page': currentPage,
//       'last_page': lastPage,
//       'total_page': totalPage,
//       'per_page': perPage,
//       'total': total,
//       'total_item': totalItem,
//       'has_next_page': hasNextPage,
//       'has_previous_page': hasPreviousPage,
//     };
//   }

//   // Helper methods
//   bool get canGoNext => hasNextPage ?? false;
//   bool get canGoPrevious => hasPreviousPage ?? false;
//   int get totalItems => totalItem ?? total ?? 0;
//   int get totalPages => totalPage ?? lastPage ?? 0;
//   int get itemsPerPage => perPage ?? 10;
//   int get currentPageNumber => currentPage ?? 1;

//   // Calculate range of items being displayed
//   String get itemRange {
//     if (totalItems == 0) return '0 items';

//     final start = ((currentPageNumber - 1) * itemsPerPage) + 1;
//     final end = (currentPageNumber * itemsPerPage).clamp(0, totalItems);

//     return '$start-$end of $totalItems items';
//   }
// }

// // Flexible API response that can handle different data types
// class FlexibleApiResponse<T> {
//   final String resCode;
//   final String message;
//   final dynamic rawData;
//   final Map<String, dynamic>? summary;
//   final PaginationMeta? pagination;

//   FlexibleApiResponse({
//     required this.resCode,
//     required this.message,
//     required this.rawData,
//     this.summary,
//     this.pagination,
//   });

//   factory FlexibleApiResponse.fromJson(Map<String, dynamic> json) {
//     final data = json['data'];
//     PaginationMeta? paginationMeta;

//     // Check if pagination info exists
//     if (json.containsKey('per_page') ||
//         json.containsKey('current_page') ||
//         json.containsKey('total_page') ||
//         json.containsKey('total_item')) {
//       paginationMeta = PaginationMeta.fromJson(json);
//     }

//     return FlexibleApiResponse<T>(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       rawData: data,
//       summary: json['summary'] as Map<String, dynamic>?,
//       pagination: paginationMeta,
//     );
//   }

//   // Get single object
//   Map<String, dynamic>? get singleObject {
//     if (rawData is Map<String, dynamic>) {
//       return rawData as Map<String, dynamic>;
//     }
//     return null;
//   }

//   // Get list of objects
//   List<Map<String, dynamic>> get listObjects {
//     if (rawData is List) {
//       return (rawData as List)
//           .map((item) => item as Map<String, dynamic>)
//           .toList();
//     }
//     return [];
//   }

//   // Get typed single object
//   T? getSingleData<T>(T Function(Map<String, dynamic>) fromJson) {
//     final obj = singleObject;
//     if (obj != null) {
//       return fromJson(obj);
//     }
//     return null;
//   }

//   // Get typed list of objects
//   List<T> getListData<T>(T Function(Map<String, dynamic>) fromJson) {
//     return listObjects.map((item) => fromJson(item)).toList();
//   }

//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasData => rawData != null;
//   bool get hasPagination => pagination != null;
//   bool get isList => rawData is List;
//   bool get isObject => rawData is Map<String, dynamic>;

//   String get statusMessage => AppResCode.resCode(resCode);
//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// // Specialized response types for your API formats
// class BannerResponse {
//   final String resCode;
//   final String message;
//   final List<String> imagePaths;
//   final Map<String, dynamic>? summary;

//   BannerResponse({
//     required this.resCode,
//     required this.message,
//     required this.imagePaths,
//     this.summary,
//   });

//   factory BannerResponse.fromJson(Map<String, dynamic> json) {
//     final data = json['data'] as Map<String, dynamic>? ?? {};
//     final imagePathsList = data['image_paths'] as List? ?? [];

//     return BannerResponse(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       imagePaths: imagePathsList.map((path) => path.toString()).toList(),
//       summary: json['summary'] as Map<String, dynamic>?,
//     );
//   }

//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasImages => imagePaths.isNotEmpty;

//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// class AppConfigResponse {
//   final String resCode;
//   final String message;
//   final AppConfigData? data;
//   final Map<String, dynamic>? summary;

//   AppConfigResponse({
//     required this.resCode,
//     required this.message,
//     this.data,
//     this.summary,
//   });

//   factory AppConfigResponse.fromJson(Map<String, dynamic> json) {
//     final dataMap = json['data'] as Map<String, dynamic>?;

//     return AppConfigResponse(
//       resCode: json['resCode'] ?? '',
//       message: json['message'] ?? '',
//       data: dataMap != null ? AppConfigData.fromJson(dataMap) : null,
//       summary: json['summary'] as Map<String, dynamic>?,
//     );
//   }

//   bool get isSuccess => resCode == '0000';
//   bool get isError => resCode != '0000';
//   bool get hasData => data != null;

//   String get errorMessage =>
//       message.isNotEmpty ? message : AppResCode.getErrorMessage(resCode);
// }

// class AppConfigData {
//   final int id;
//   final String title;
//   final String? value1;
//   final String? value2;
//   final String? value3;
//   final String? value4;
//   final String? imagePath1;
//   final String? imagePath2;
//   final String? imagePath3;
//   final String? imagePath4;
//   final String? imagePath5;
//   final int status;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   AppConfigData({
//     required this.id,
//     required this.title,
//     this.value1,
//     this.value2,
//     this.value3,
//     this.value4,
//     this.imagePath1,
//     this.imagePath2,
//     this.imagePath3,
//     this.imagePath4,
//     this.imagePath5,
//     required this.status,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory AppConfigData.fromJson(Map<String, dynamic> json) {
//     return AppConfigData(
//       id: json['id'] ?? 0,
//       title: json['title'] ?? '',
//       value1: json['value1'],
//       value2: json['value2'],
//       value3: json['value3'],
//       value4: json['value4'],
//       imagePath1: json['image_path1'],
//       imagePath2: json['image_path2'],
//       imagePath3: json['image_path3'],
//       imagePath4: json['image_path4'],
//       imagePath5: json['image_path5'],
//       status: json['status'] ?? 0,
//       createdAt: json['created_at'] != null
//           ? DateTime.tryParse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.tryParse(json['updated_at'])
//           : null,
//     );
//   }

//   List<String> get allImagePaths {
//     return [
//       imagePath1,
//       imagePath2,
//       imagePath3,
//       imagePath4,
//       imagePath5,
//     ].where((path) => path != null && path.isNotEmpty).cast<String>().toList();
//   }
// }
