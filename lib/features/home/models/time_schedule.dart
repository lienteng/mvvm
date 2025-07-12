import 'package:flutter/material.dart';

class TimeSchedule {
  final int scheduleId;
  final int empId;
  final int companyShiftId;
  final String scheduleDate;
  final String stTime;
  final String frTime;
  final String toTime;
  final String locationName;
  final String shiftName;
  final String checkType;

  TimeSchedule({
    required this.scheduleId,
    required this.empId,
    required this.companyShiftId,
    required this.scheduleDate,
    required this.stTime,
    required this.frTime,
    required this.toTime,
    required this.locationName,
    required this.shiftName,
    required this.checkType,
  });

  factory TimeSchedule.fromJson(Map<String, dynamic> json) {
    return TimeSchedule(
      scheduleId: json['schedule_id'],
      empId: json['emp_id'],
      companyShiftId: json['company_shift_id'],
      scheduleDate: json['schedule_date'],
      stTime: json['st_time'],
      frTime: json['fr_time'],
      toTime: json['to_time'],
      locationName: json['location_name'],
      shiftName: json['shift_name'],
      checkType: json['check_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule_id': scheduleId,
      'emp_id': empId,
      'company_shift_id': companyShiftId,
      'schedule_date': scheduleDate,
      'st_time': stTime,
      'fr_time': frTime,
      'to_time': toTime,
      'location_name': locationName,
      'shift_name': shiftName,
      'check_type': checkType,
    };
  }

  // Helper getters
  DateTime get scheduleDateParsed => DateTime.parse(scheduleDate);

  TimeOfDay get startTime => _parseTimeOfDay(stTime);
  TimeOfDay get fromTime => _parseTimeOfDay(frTime);
  TimeOfDay get endTime => _parseTimeOfDay(toTime);

  bool get isCheckIn => checkType.toUpperCase() == 'IN';
  bool get isCheckOut => checkType.toUpperCase() == 'OUT';

  String get formattedDate {
    final date = scheduleDateParsed;
    return '${date.day}/${date.month}/${date.year}';
  }

  String get formattedShiftTime => '$stTime - $toTime';

  List<double> get coordinates {
    final coords = locationName.split(', ');
    if (coords.length == 2) {
      return [double.parse(coords[0]), double.parse(coords[1])];
    }
    return [0.0, 0.0];
  }

  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
