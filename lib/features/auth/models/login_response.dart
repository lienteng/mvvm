class LoginResponse {
  final String resCode;
  final String message;
  final UserData? data; // <-- nullable!
  final String? token; // <-- nullable!
  final String? expiresIn; // <-- nullable!
  final String? refreshToken; // <-- nullable!

  LoginResponse({
    required this.resCode,
    required this.message,
    this.data,
    this.token,
    this.expiresIn,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      resCode: json['resCode'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      token: json['token'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resCode': resCode,
      'message': message,
      'data': data?.toJson(),
      'token': token,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
    };
  }
}


class UserData {
  final int id;
  final String userName;
  final String password;
  final String? avatar;
  final int empId;
  final int? roleId;
  final String createdAt;
  final String updatedAt;
  final String? deviceToken;
  final String? fcmToken;
  final String status;
  final String? confirmOtp;
  final Employee employee;
  final List<UserRole> userRoles;
  final List<UserPermission> userPermissions;
  final List<WebMenu> webMenu;

  UserData({
    required this.id,
    required this.userName,
    required this.password,
    this.avatar,
    required this.empId,
    this.roleId,
    required this.createdAt,
    required this.updatedAt,
    this.deviceToken,
    this.fcmToken,
    required this.status,
    this.confirmOtp,
    required this.employee,
    required this.userRoles,
    required this.userPermissions,
    required this.webMenu,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      userName: json['user_name'],
      password: json['password'],
      avatar: json['avatar'],
      empId: json['emp_id'],
      roleId: json['role_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deviceToken: json['device_token'],
      fcmToken: json['fcm_token'],
      status: json['status'],
      confirmOtp: json['confirm_otp'],
      employee: Employee.fromJson(json['Employee']),
      userRoles: (json['UserRoles'] as List)
          .map((e) => UserRole.fromJson(e))
          .toList(),
      userPermissions: (json['UserPermissions'] as List)
          .map((e) => UserPermission.fromJson(e))
          .toList(),
      webMenu: (json['web_menu'] as List)
          .map((e) => WebMenu.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'password': password,
      'avatar': avatar,
      'emp_id': empId,
      'role_id': roleId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'device_token': deviceToken,
      'fcm_token': fcmToken,
      'status': status,
      'confirm_otp': confirmOtp,
      'Employee': employee.toJson(),
      'UserRoles': userRoles.map((e) => e.toJson()).toList(),
      'UserPermissions': userPermissions.map((e) => e.toJson()).toList(),
      'web_menu': webMenu.map((e) => e.toJson()).toList(),
    };
  }
}

class Employee {
  final int id;
  final String name;
  final String empNo;
  final String mobilePhone;
  final String email;
  final String duties;
  final Position position;
  final Province province;
  final District district;
  final Gender gender;

  Employee({
    required this.id,
    required this.name,
    required this.empNo,
    required this.mobilePhone,
    required this.email,
    required this.duties,
    required this.position,
    required this.province,
    required this.district,
    required this.gender,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      empNo: json['emp_no'],
      mobilePhone: json['mobile_phone'],
      email: json['email'],
      duties: json['duties'],
      position: Position.fromJson(json['Position']),
      province: Province.fromJson(json['Province']),
      district: District.fromJson(json['District']),
      gender: Gender.fromJson(json['Gender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emp_no': empNo,
      'mobile_phone': mobilePhone,
      'email': email,
      'duties': duties,
      'Position': position.toJson(),
      'Province': province.toJson(),
      'District': district.toJson(),
      'Gender': gender.toJson(),
    };
  }
}

class Position {
  final String nameLo;
  final String nameEn;

  Position({required this.nameLo, required this.nameEn});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      nameLo: json['name_lo'],
      nameEn: json['name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_lo': nameLo,
      'name_en': nameEn,
    };
  }
}

class Province {
  final String nameLo;
  final String nameEn;

  Province({required this.nameLo, required this.nameEn});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      nameLo: json['name_lo'],
      nameEn: json['name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_lo': nameLo,
      'name_en': nameEn,
    };
  }
}

class District {
  final String nameLo;
  final String nameEn;

  District({required this.nameLo, required this.nameEn});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      nameLo: json['name_lo'],
      nameEn: json['name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_lo': nameLo,
      'name_en': nameEn,
    };
  }
}

class Gender {
  final String nameLo;
  final String nameEn;

  Gender({required this.nameLo, required this.nameEn});

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      nameLo: json['name_lo'],
      nameEn: json['name_en'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_lo': nameLo,
      'name_en': nameEn,
    };
  }
}

class UserRole {
  final int id;
  final int roleId;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final Role role;

  UserRole({
    required this.id,
    required this.roleId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'],
      roleId: json['role_id'],
      userId: json['user_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      role: Role.fromJson(json['Role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role_id': roleId,
      'user_id': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Role': role.toJson(),
    };
  }
}

class Role {
  final String name;
  final String? description;
  final int status;

  Role({
    required this.name,
    this.description,
    required this.status,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'status': status,
    };
  }
}

class UserPermission {
  final int id;
  final int userId;
  final int permissionId;
  final String createdAt;
  final String updatedAt;
  final Permission permission;

  UserPermission({
    required this.id,
    required this.userId,
    required this.permissionId,
    required this.createdAt,
    required this.updatedAt,
    required this.permission,
  });

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      id: json['id'],
      userId: json['user_id'],
      permissionId: json['permission_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      permission: Permission.fromJson(json['Permission']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'permission_id': permissionId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'Permission': permission.toJson(),
    };
  }
}

class Permission {
  final int id;
  final String name;
  final String description;
  final int status;

  Permission({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }
}

class WebMenu {
  final int menuId;
  final String name;
  final String? route;
  final String icon;
  final String description;
  final List<SubPermission> subPermissions;

  WebMenu({
    required this.menuId,
    required this.name,
    this.route,
    required this.icon,
    required this.description,
    required this.subPermissions,
  });

  factory WebMenu.fromJson(Map<String, dynamic> json) {
    return WebMenu(
      menuId: json['menu_id'],
      name: json['name'],
      route: json['route'],
      icon: json['icon'],
      description: json['description'],
      subPermissions: (json['sub_permissions'] as List)
          .map((e) => SubPermission.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      'name': name,
      'route': route,
      'icon': icon,
      'description': description,
      'sub_permissions': subPermissions.map((e) => e.toJson()).toList(),
    };
  }
}

class SubPermission {
  final int menuId;
  final int sPermissionId;
  final String name;
  final String description;
  final String route;
  final String icon;

  SubPermission({
    required this.menuId,
    required this.sPermissionId,
    required this.name,
    required this.description,
    required this.route,
    required this.icon,
  });

  factory SubPermission.fromJson(Map<String, dynamic> json) {
    return SubPermission(
      menuId: json['menu_id'],
      sPermissionId: json['s_permission_id'],
      name: json['name'],
      description: json['description'],
      route: json['route'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menuId,
      's_permission_id': sPermissionId,
      'name': name,
      'description': description,
      'route': route,
      'icon': icon,
    };
  }
}
