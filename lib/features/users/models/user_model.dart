class UserModel {
  final int id;
  final String userName;
  final String? avatar;
  final int empId;
  final String? deviceId;
  final String? fcmToken;
  final String status;
  final EmployeeModel? employee;
  final List<RoleModel> roles;
  final List<PermissionModel> permissions;

  UserModel({
    required this.id,
    required this.userName,
    this.avatar,
    required this.empId,
    this.deviceId,
    this.fcmToken,
    required this.status,
    this.employee,
    required this.roles,
    required this.permissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['user_name'],
      avatar: json['avatar'],
      empId: json['emp_id'],
      deviceId: json['device_id'],
      fcmToken: json['fcm_token'],
      status: json['status'],
      employee: json['Employee'] != null
          ? EmployeeModel.fromJson(json['Employee'])
          : null,
      roles: (json['Roles'] as List).map((e) => RoleModel.fromJson(e)).toList(),
      permissions: (json['Permissions'] as List)
          .map((e) => PermissionModel.fromJson(e))
          .toList(),
    );
  }
}

class EmployeeModel {
  final int id;
  final String name;
  final String lastName;
  final String empNo;
  final String mobilePhone;
  final String? email;
  final String? duties;
  final String? village;
  final String? signAt;
  final PositionModel? position;
  final ProvinceModel? province;
  final DistrictModel? district;
  final GenderModel? gender;
  final NationalityModel? nationality;
  final EthnicityModel? ethnicity;
  final BranchModel? branch;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.empNo,
    required this.mobilePhone,
    this.email,
    this.duties,
    this.village,
    this.signAt,
    this.position,
    this.province,
    this.district,
    this.gender,
    this.nationality,
    this.ethnicity,
    this.branch,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      empNo: json['emp_no'],
      mobilePhone: json['mobile_phone'],
      email: json['email'],
      duties: json['duties'],
      village: json['village'],
      signAt: json['signAt'],
      position: json['Position'] != null
          ? PositionModel.fromJson(json['Position'])
          : null,
      province: json['Province'] != null
          ? ProvinceModel.fromJson(json['Province'])
          : null,
      district: json['District'] != null
          ? DistrictModel.fromJson(json['District'])
          : null,
      gender: json['Gender'] != null
          ? GenderModel.fromJson(json['Gender'])
          : null,
      nationality: json['Nationality'] != null
          ? NationalityModel.fromJson(json['Nationality'])
          : null,
      ethnicity: json['Ethnicity'] != null
          ? EthnicityModel.fromJson(json['Ethnicity'])
          : null,
      branch: json['Branch'] != null
          ? BranchModel.fromJson(json['Branch'])
          : null,
    );
  }
}

// Supporting nested models

class RoleModel {
  final int id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'], name: json['name']);
  }
}

class PermissionModel {
  final int id;
  final String name;

  PermissionModel({required this.id, required this.name});

  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(id: json['id'], name: json['name']);
  }
}

class PositionModel {
  final String nameLo;
  final String nameEn;

  PositionModel({required this.nameLo, required this.nameEn});

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class ProvinceModel {
  final String nameLo;
  final String nameEn;

  ProvinceModel({required this.nameLo, required this.nameEn});

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class DistrictModel {
  final String nameLo;
  final String nameEn;

  DistrictModel({required this.nameLo, required this.nameEn});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class GenderModel {
  final String nameLo;
  final String nameEn;

  GenderModel({required this.nameLo, required this.nameEn});

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class NationalityModel {
  final String nameLo;
  final String nameEn;

  NationalityModel({required this.nameLo, required this.nameEn});

  factory NationalityModel.fromJson(Map<String, dynamic> json) {
    return NationalityModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class EthnicityModel {
  final String nameLo;
  final String nameEn;

  EthnicityModel({required this.nameLo, required this.nameEn});

  factory EthnicityModel.fromJson(Map<String, dynamic> json) {
    return EthnicityModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}

class BranchModel {
  final String nameLo;
  final String nameEn;

  BranchModel({required this.nameLo, required this.nameEn});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(nameLo: json['name_lo'], nameEn: json['name_en']);
  }
}
