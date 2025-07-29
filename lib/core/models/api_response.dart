class ApiResponse<T> {
  final String resCode;
  final String message;
  final List<T> data;
  final String? companyCode;
  final int perPage;
  final int currentPage;
  final int totalPage;
  final int totalItem;

  ApiResponse({
    required this.resCode,
    required this.message,
    required this.data,
    required this.companyCode,
    required this.perPage,
    required this.currentPage,
    required this.totalPage,
    required this.totalItem,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse(
      resCode: json['resCode'],
      message: json['message'],
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
      companyCode: json['companyCode'],
      perPage: int.tryParse(json['per_page'].toString()) ?? 0,
      currentPage: int.tryParse(json['current_page'].toString()) ?? 0,
      totalPage: int.tryParse(json['total_page'].toString()) ?? 0,
      totalItem: int.tryParse(json['total_item'].toString()) ?? 0,
    );
  }
}

class ApiResponseDataList<T> {
  final String resCode;
  final String message;
  final List<T> data;

  ApiResponseDataList({
    required this.resCode,
    required this.message,
    required this.data,
  });

  factory ApiResponseDataList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponseDataList(
      resCode: json['resCode'],
      message: json['message'],
      data: (json['data'] as List).map((e) => fromJsonT(e)).toList(),
    );
  }
}

class ApiResponseSingle<T> {
  final String resCode;
  final String message;
  final T data;

  ApiResponseSingle({
    required this.resCode,
    required this.message,
    required this.data,
  });

  factory ApiResponseSingle.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponseSingle(
      resCode: json['resCode'],
      message: json['message'],
      data: fromJsonT(json['data']),
    );
  }
}
