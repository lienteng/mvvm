class Employee {
  final String id;
  final String name;
  final String empNo;
  final String email;
  final String department;
  final bool isActive;

  Employee({
    required this.id,
    required this.name,
    required this.empNo,
    required this.email,
    required this.department,
    this.isActive = true,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      empNo: json['emp_no'],
      email: json['email'],
      department: json['department'],
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emp_no': empNo,
      'email': email,
      'department': department,
      'is_active': isActive,
    };
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Employee && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
