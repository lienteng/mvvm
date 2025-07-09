class ReportProblem {
  final int id;
  final int scheduleDetailId;
  final String description;
  final String date;
  final String? status;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final ScheduleDetail scheduleDetail;
  final List<ReportProblemFile> reportProblemFiles;

  ReportProblem({
    required this.id,
    required this.scheduleDetailId,
    required this.description,
    required this.date,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.scheduleDetail,
    required this.reportProblemFiles,
  });

  factory ReportProblem.fromJson(Map<String, dynamic> json) {
    return ReportProblem(
      id: json['id'],
      scheduleDetailId: json['schedule_detail_id'],
      description: json['description'],
      date: json['date'],
      status: json['status'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'] ?? '',
      scheduleDetail: ScheduleDetail.fromJson(json['ScheduleDetail']),
      reportProblemFiles: (json['ReportProblemFiles'] as List)
          .map((e) => ReportProblemFile.fromJson(e))
          .toList(),
    );
  }
}

class ScheduleDetail {
  final int id;
  final int empId;
  final int companyShiftId;
  final String date;
  final String stTime;
  final String frTime;
  final String toTime;
  final int status;
  final String createdAt;
  final String updatedAt;
  final Employee employee;

  ScheduleDetail({
    required this.id,
    required this.empId,
    required this.companyShiftId,
    required this.date,
    required this.stTime,
    required this.frTime,
    required this.toTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.employee,
  });

  factory ScheduleDetail.fromJson(Map<String, dynamic> json) {
    return ScheduleDetail(
      id: json['id'],
      empId: json['emp_id'],
      companyShiftId: json['company_shift_id'],
      date: json['date'],
      stTime: json['st_time'],
      frTime: json['fr_time'],
      toTime: json['to_time'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      employee: Employee.fromJson(json['Employee']),
    );
  }
}

class Employee {
  final int id;
  final int companyId;
  final int? departmentId;
  final int branchId;
  final String empNo;
  final int provinceId;
  final int districtId;
  final String village;
  final String name;
  final String lastName;
  final int genderId;
  final String birthday;
  final int status;
  final int nationalId;
  final int ethnicityId;
  final String avatar;
  final String email;
  final String mobilePhone;
  final String telephone;
  final String duties;
  final int positionId;
  final String documentPath;
  final String signAt;
  final String? resignAt;
  final String createdAt;
  final String updatedAt;

  Employee({
    required this.id,
    required this.companyId,
    this.departmentId,
    required this.branchId,
    required this.empNo,
    required this.provinceId,
    required this.districtId,
    required this.village,
    required this.name,
    required this.lastName,
    required this.genderId,
    required this.birthday,
    required this.status,
    required this.nationalId,
    required this.ethnicityId,
    required this.avatar,
    required this.email,
    required this.mobilePhone,
    required this.telephone,
    required this.duties,
    required this.positionId,
    required this.documentPath,
    required this.signAt,
    this.resignAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      companyId: json['company_id'],
      departmentId: json['department_id'],
      branchId: json['branch_id'],
      empNo: json['emp_no'],
      provinceId: json['province_id'],
      districtId: json['district_id'],
      village: json['village'],
      name: json['name'],
      lastName: json['last_name'],
      genderId: json['gender_id'],
      birthday: json['birthday'],
      status: json['status'],
      nationalId: json['national_id'],
      ethnicityId: json['ethnicity_id'],
      avatar: json['avatar'],
      email: json['email'],
      mobilePhone: json['mobile_phone'],
      telephone: json['telephone'],
      duties: json['duties'],
      positionId: json['position_id'],
      documentPath: json['document_path'],
      signAt: json['signAt'],
      resignAt: json['resignAt'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ReportProblemFile {
  final int id;
  final int problemId;
  final String fileName;
  final String originalFileName;
  final String fileType;
  final int fileSize;
  final String createdAt;
  final String updatedAt;

  ReportProblemFile({
    required this.id,
    required this.problemId,
    required this.fileName,
    required this.originalFileName,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReportProblemFile.fromJson(Map<String, dynamic> json) {
    return ReportProblemFile(
      id: json['id'],
      problemId: json['problem_id'],
      fileName: json['file_name'],
      originalFileName: json['original_file_name'],
      fileType: json['file_type'],
      fileSize: json['file_size'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
