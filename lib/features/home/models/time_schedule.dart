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

  /// Factory method for deserialization
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

  /// Serialization method
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

  /// Helpers
  DateTime get scheduleDateParsed => DateTime.parse(scheduleDate);

  TimeOfDay get startTime => _parseTimeOfDay(stTime);
  TimeOfDay get fromTime => _parseTimeOfDay(frTime);
  TimeOfDay get endTime => _parseTimeOfDay(toTime);

  bool get isCheckIn => checkType.toUpperCase() == 'IN';
  bool get isCheckOut => checkType.toUpperCase() == 'OUT';

  String get formattedDate {
    final date = scheduleDateParsed;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String get formattedShiftTime => '$stTime - $toTime';

  List<double> get coordinates {
    try {
      final parts = locationName.split(',');
      if (parts.length == 2) {
        return [double.parse(parts[0].trim()), double.parse(parts[1].trim())];
      }
    } catch (_) {}
    return [0.0, 0.0]; // Fallback on parse error
  }

  /// Internal helper for TimeOfDay parsing
  TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  /// For debugging/logging
  @override
  String toString() {
    return 'TimeSchedule(scheduleId: $scheduleId, empId: $empId, '
        'date: $formattedDate, shift: $shiftName, '
        'from: $frTime, to: $toTime, type: $checkType)';
  }
}
