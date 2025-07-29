class AttendanceRecord {
  final String id;
  final String userId;
  final String userName;
  final String action; // 'CHECK_IN' or 'CHECK_OUT'
  final DateTime timestamp;
  final String deviceId;
  final String? location;
  final bool isSync; // Whether synced to server

  AttendanceRecord({
    required this.id,
    required this.userId,
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.deviceId,
    this.location,
    this.isSync = false,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      action: json['action'],
      timestamp: DateTime.parse(json['timestamp']),
      deviceId: json['device_id'],
      location: json['location'],
      isSync: json['is_sync'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'action': action,
      'timestamp': timestamp.toIso8601String(),
      'device_id': deviceId,
      'location': location,
      'is_sync': isSync,
    };
  }

  AttendanceRecord copyWith({
    String? id,
    String? userId,
    String? userName,
    String? action,
    DateTime? timestamp,
    String? deviceId,
    String? location,
    bool? isSync,
  }) {
    return AttendanceRecord(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      deviceId: deviceId ?? this.deviceId,
      location: location ?? this.location,
      isSync: isSync ?? this.isSync,
    );
  }

  bool get isCheckIn => action == 'CHECK_IN';
  bool get isCheckOut => action == 'CHECK_OUT';

  String get formattedTime {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  String get formattedDate {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  String get formattedDateTime {
    return '${formattedDate} at ${formattedTime}';
  }
}
