import 'app_localizations.dart';

class AppLocalizationsTh extends AppLocalizations {
  @override
  String get appName => 'แอป Flutter MVVM';

  // Common
  @override
  String get ok => 'ตกลง';
  @override
  String get cancel => 'ยกเลิก';
  @override
  String get yes => 'ใช่';
  @override
  String get no => 'ไม่';
  @override
  String get save => 'บันทึก';
  @override
  String get delete => 'ลบ';
  @override
  String get edit => 'แก้ไข';
  @override
  String get add => 'เพิ่ม';
  @override
  String get search => 'ค้นหา';
  @override
  String get loading => 'กำลังโหลด...';
  @override
  String get error => 'ข้อผิดพลาด';
  @override
  String get success => 'สำเร็จ';
  @override
  String get warning => 'คำเตือน';
  @override
  String get info => 'ข้อมูล';
  @override
  String get retry => 'ลองใหม่';
  @override
  String get close => 'ปิด';
  @override
  String get back => 'กลับ';
  @override
  String get next => 'ถัดไป';
  @override
  String get previous => 'ก่อนหน้า';
  @override
  String get done => 'เสร็จสิ้น';
  @override
  String get settings => 'การตั้งค่า';
  @override
  String get profile => 'โปรไฟล์';
  @override
  String get logout => 'ออกจากระบบ';
  @override
  String get login => 'เข้าสู่ระบบ';
  @override
  String get register => 'สมัครสมาชิก';
  @override
  String get forgotPassword => 'ลืมรหัสผ่าน';
  @override
  String get changePassword => 'เปลี่ยนรหัสผ่าน';
  @override
  String get confirmPassword => 'ยืนยันรหัสผ่าน';
  @override
  String get email => 'อีเมล';
  @override
  String get password => 'รหัสผ่าน';
  @override
  String get username => 'ชื่อผู้ใช้';
  @override
  String get phone => 'โทรศัพท์';
  @override
  String get address => 'ที่อยู่';
  @override
  String get name => 'ชื่อ';
  @override
  String get firstName => 'ชื่อจริง';
  @override
  String get lastName => 'นามสกุล';
  @override
  String get dateOfBirth => 'วันเกิด';
  @override
  String get gender => 'เพศ';
  @override
  String get male => 'ชาย';
  @override
  String get female => 'หญิง';
  @override
  String get other => 'อื่นๆ';

  // Navigation
  @override
  String get home => 'หน้าหลัก';
  @override
  String get timeTracking => 'ติดตามเวลา';
  @override
  String get attendance => 'การเข้าร่วม';
  @override
  String get reports => 'รายงาน';
  @override
  String get notifications => 'การแจ้งเตือน';
  @override
  String get help => 'ช่วยเหลือ';
  @override
  String get about => 'เกี่ยวกับ';

  // Authentication
  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';
  @override
  String get signInToContinue => 'เข้าสู่ระบบเพื่อดำเนินการต่อ';
  @override
  String get dontHaveAccount => 'ยังไม่มีบัญชี?';
  @override
  String get alreadyHaveAccount => 'มีบัญชีแล้ว?';
  @override
  String get createAccount => 'สร้างบัญชี';
  @override
  String get signIn => 'เข้าสู่ระบบ';
  @override
  String get signUp => 'สมัครสมาชิก';
  @override
  String get signOut => 'ออกจากระบบ';
  @override
  String get forgotPasswordTitle => 'ลืมรหัสผ่าน';
  @override
  String get forgotPasswordSubtitle => 'ใส่อีเมลเพื่อรีเซ็ตรหัสผ่าน';
  @override
  String get resetPassword => 'รีเซ็ตรหัสผ่าน';
  @override
  String get sendResetLink => 'ส่งลิงก์รีเซ็ต';
  @override
  String get backToLogin => 'กลับไปเข้าสู่ระบบ';
  @override
  String get passwordResetSent => 'ลิงก์รีเซ็ตรหัสผ่านถูกส่งไปยังอีเมลแล้ว';
  @override
  String get invalidCredentials => 'อีเมลหรือรหัสผ่านไม่ถูกต้อง';
  @override
  String get accountCreated => 'สร้างบัญชีสำเร็จแล้ว';
  @override
  String get loginSuccessful => 'เข้าสู่ระบบสำเร็จ';
  @override
  String get logoutSuccessful => 'ออกจากระบบสำเร็จ';

  // Home Screen
  @override
  String get goodMorning => 'สวัสดีตอนเช้า';
  @override
  String get goodAfternoon => 'สวัสดีตอนบ่าย';
  @override
  String get goodEvening => 'สวัสดีตอนเย็น';
  @override
  String get todaySchedule => 'ตารางวันนี้';
  @override
  String get recentTransactions => 'ธุรกรรมล่าสุด';
  @override
  String get quickActions => 'การดำเนินการด่วน';
  @override
  String get viewAll => 'ดูทั้งหมด';
  @override
  String get noDataAvailable => 'ไม่มีข้อมูล';
  @override
  String get refreshData => 'รีเฟรชข้อมูล';

  // Time Tracking
  @override
  String get checkIn => 'เช็คอิน';
  @override
  String get checkOut => 'เช็คเอาท์';
  @override
  String get breakStart => 'เริ่มพัก';
  @override
  String get breakEnd => 'สิ้นสุดพัก';
  @override
  String get totalHours => 'ชั่วโมงทั้งหมด';
  @override
  String get workingHours => 'ชั่วโมงทำงาน';
  @override
  String get breakTime => 'เวลาพัก';
  @override
  String get overtime => 'ล่วงเวลา';
  @override
  String get location => 'สถานที่';
  @override
  String get currentLocation => 'สถานที่ปัจจุบัน';
  @override
  String get workLocation => 'สถานที่ทำงาน';
  @override
  String get timeTrackingHistory => 'ประวัติการติดตามเวลา';
  @override
  String get todayActivity => 'กิจกรรมวันนี้';
  @override
  String get thisWeek => 'สัปดาห์นี้';
  @override
  String get thisMonth => 'เดือนนี้';
  @override
  String get selectDate => 'เลือกวันที่';
  @override
  String get selectTime => 'เลือกเวลา';

  // Biometric Attendance
  @override
  String get biometricAttendance => 'การเข้าร่วมด้วยไบโอเมตริก';
  @override
  String get fingerprintAuth => 'การยืนยันลายนิ้วมือ';
  @override
  String get faceIdAuth => 'การยืนยันใบหน้า';
  @override
  String get biometricNotAvailable => 'การยืนยันไบโอเมตริกไม่สามารถใช้ได้';
  @override
  String get biometricNotEnrolled => 'ไม่มีข้อมูลไบโอเมตริก';
  @override
  String get authenticationFailed => 'การยืนยันล้มเหลว';
  @override
  String get authenticationSuccessful => 'การยืนยันสำเร็จ';
  @override
  String get selectEmployee => 'เลือกพนักงาน';
  @override
  String get attendanceRecorded => 'บันทึกการเข้าร่วมสำเร็จ';
  @override
  String get attendanceHistory => 'ประวัติการเข้าร่วม';
  @override
  String get todaySummary => 'สรุปวันนี้';
  @override
  String get syncStatus => 'สถานะการซิงค์';
  @override
  String get syncSuccessful => 'การซิงค์สำเร็จ';
  @override
  String get syncFailed => 'การซิงค์ล้มเหลว';
  @override
  String get offlineMode => 'โหมดออฟไลน์';
  @override
  String get onlineMode => 'โหมดออนไลน์';

  // Settings
  @override
  String get generalSettings => 'การตั้งค่าทั่วไป';
  @override
  String get accountSettings => 'การตั้งค่าบัญชี';
  @override
  String get privacySettings => 'การตั้งค่าความเป็นส่วนตัว';
  @override
  String get notificationSettings => 'การตั้งค่าการแจ้งเตือน';
  @override
  String get themeSettings => 'การตั้งค่าธีม';
  @override
  String get languageSettings => 'การตั้งค่าภาษา';
  @override
  String get securitySettings => 'การตั้งค่าความปลอดภัย';
  @override
  String get dataSettings => 'การตั้งค่าข้อมูล';
  @override
  String get aboutApp => 'เกี่ยวกับแอป';
  @override
  String get version => 'เวอร์ชัน';
  @override
  String get buildNumber => 'หมายเลข Build';
  @override
  String get developer => 'นักพัฒนา';
  @override
  String get contactSupport => 'ติดต่อฝ่ายสนับสนุน';
  @override
  String get rateApp => 'ให้คะแนนแอป';
  @override
  String get shareApp => 'แชร์แอป';
  @override
  String get termsOfService => 'เงื่อนไขการใช้งาน';
  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  // Theme Settings
  @override
  String get themeMode => 'โหมดธีม';
  @override
  String get lightTheme => 'ธีมสว่าง';
  @override
  String get darkTheme => 'ธีมมืด';
  @override
  String get systemTheme => 'ธีมระบบ';
  @override
  String get themeColor => 'สีธีม';
  @override
  String get blue => 'สีน้ำเงิน';
  @override
  String get purple => 'สีม่วง';
  @override
  String get green => 'สีเขียว';
  @override
  String get orange => 'สีส้ม';
  @override
  String get red => 'สีแดง';
  @override
  String get teal => 'สีฟ้าอมเขียว';
  @override
  String get preview => 'ตัวอย่าง';
  @override
  String get resetToDefaults => 'รีเซ็ตเป็นค่าเริ่มต้น';
  @override
  String get themeResetConfirm =>
      'คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตการตั้งค่าธีม?';

  // Language Settings
  @override
  String get selectLanguage => 'เลือกภาษา';
  @override
  String get currentLanguage => 'ภาษาปัจจุบัน';
  @override
  String get languageChanged => 'เปลี่ยนภาษาสำเร็จแล้ว';
  @override
  String get restartRequired => 'ต้องเปิดแอปใหม่เพื่อใช้การเปลี่ยนแปง';
  @override
  String get english => 'English (อังกฤษ)';
  @override
  String get lao => 'ລາວ (ลาว)';
  @override
  String get thai => 'ไทย';
  @override
  String get chinese => '中文 (จีน)';

  // Error Messages
  @override
  String get networkError => 'ข้อผิดพลาดการเชื่อมต่อเครือข่าย';
  @override
  String get serverError => 'เกิดข้อผิดพลาดของเซิร์ฟเวอร์';
  @override
  String get unknownError => 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ';
  @override
  String get validationError => 'ข้อผิดพลาดการตรวจสอบ';
  @override
  String get permissionDenied => 'ปฏิเสธการอนุญาต';
  @override
  String get locationPermissionDenied => 'ปฏิเสธการอนุญาตตำแหน่ง';
  @override
  String get cameraPermissionDenied => 'ปฏิเสธการอนุญาตกล้อง';
  @override
  String get storagePermissionDenied => 'ปฏิเสธการอนุญาตพื้นที่เก็บข้อมูล';
  @override
  String get biometricPermissionDenied => 'ปฏิเสธการอนุญาตไบโอเมตริก';
  @override
  String get sessionExpired => 'หมดเวลาเซสชัน';
  @override
  String get accountLocked => 'บัญชีถูกล็อก';
  @override
  String get tooManyAttempts => 'พยายามมากเกินไป';

  // Validation Messages
  @override
  String get fieldRequired => 'ช่องนี้จำเป็นต้องกรอก';
  @override
  String get invalidEmail => 'อีเมลไม่ถูกต้อง';
  @override
  String get passwordTooShort => 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
  @override
  String get passwordsDoNotMatch => 'รหัสผ่านไม่ตรงกัน';
  @override
  String get invalidPhoneNumber => 'หมายเลขโทรศัพท์ไม่ถูกต้อง';
  @override
  String get invalidDate => 'วันที่ไม่ถูกต้อง';
  @override
  String get invalidTime => 'เวลาไม่ถูกต้อง';

  // Report Problem
  @override
  String get reportProblem => 'รายงานปัญหา';
  @override
  String get problemTitle => 'หัวข้อปัญหา';
  @override
  String get problemDescription => 'รายละเอียดปัญหา';
  @override
  String get problemCategory => 'ประเภทปัญหา';
  @override
  String get urgencyLevel => 'ระดับความเร่งด่วน';
  @override
  String get low => 'ต่ำ';
  @override
  String get medium => 'ปานกลาง';
  @override
  String get high => 'สูง';
  @override
  String get critical => 'วิกฤต';
  @override
  String get submitReport => 'ส่งรายงาน';
  @override
  String get reportSubmitted => 'ส่งรายงานสำเร็จแล้ว';
  @override
  String get reportHistory => 'ประวัติรายงาน';
  @override
  String get reportStatus => 'สถานะรายงาน';
  @override
  String get pending => 'รอดำเนินการ';
  @override
  String get inProgress => 'กำลังดำเนินการ';
  @override
  String get resolved => 'แก้ไขแล้ว';
  @override
  String get closed => 'ปิดแล้ว';

  // Notifications
  @override
  String get newNotification => 'การแจ้งเตือนใหม่';
  @override
  String get markAsRead => 'ทำเครื่องหมายว่าอ่านแล้ว';
  @override
  String get markAllAsRead => 'ทำเครื่องหมายทั้งหมดว่าอ่านแล้ว';
  @override
  String get clearAll => '���บทั้งหมด';
  @override
  String get noNotifications => 'ไม่มีการแจ้งเตือน';
  @override
  String get pushNotifications => 'การแจ้งเตือนแบบ Push';
  @override
  String get emailNotifications => 'การแจ้งเตือนทางอีเมล';
  @override
  String get smsNotifications => 'การแจ้งเตือนทาง SMS';
  @override
  String get notificationSound => 'เสียงการแจ้งเตือน';
  @override
  String get vibration => 'การสั่น';

  // Date and Time
  @override
  String get today => 'วันนี้';
  @override
  String get yesterday => 'เมื่อวาน';
  @override
  String get tomorrow => 'พรุ่งนี้';
  @override
  String get thisWeekShort => 'สัปดาห์นี้';
  @override
  String get lastWeek => 'สัปดาห์ที่แล้ว';
  @override
  String get nextWeek => 'สัปดาห์หน้า';
  @override
  String get thisMonthShort => 'เดือนนี้';
  @override
  String get lastMonth => 'เดือนที่แล้ว';
  @override
  String get nextMonth => 'เดือนหน้า';
  @override
  String get thisYear => 'ปีนี้';
  @override
  String get lastYear => 'ปีที่แล้ว';
  @override
  String get nextYear => 'ปีหน้า';

  // Days of Week
  @override
  String get monday => 'วันจันทร์';
  @override
  String get tuesday => 'วันอังคาร';
  @override
  String get wednesday => 'วันพุธ';
  @override
  String get thursday => 'วันพฤหัสบดี';
  @override
  String get friday => 'วันศุกร์';
  @override
  String get saturday => 'วันเสาร์';
  @override
  String get sunday => 'วันอาทิตย์';

  // Months
  @override
  String get january => 'มกราคม';
  @override
  String get february => 'กุมภาพันธ์';
  @override
  String get march => 'มีนาคม';
  @override
  String get april => 'เมษายน';
  @override
  String get may => 'พฤษภาคม';
  @override
  String get june => 'มิถุนายน';
  @override
  String get july => 'กรกฎาคม';
  @override
  String get august => 'สิงหาคม';
  @override
  String get september => 'กันยายน';
  @override
  String get october => 'ตุลาคม';
  @override
  String get november => 'พฤศจิกายน';
  @override
  String get december => 'ธันวาคม';
}
