import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  @override
  String get appName => 'Flutter MVVM App';

  // Common
  @override
  String get ok => 'OK';
  @override
  String get cancel => 'Cancel';
  @override
  String get yes => 'Yes';
  @override
  String get no => 'No';
  @override
  String get save => 'Save';
  @override
  String get delete => 'Delete';
  @override
  String get edit => 'Edit';
  @override
  String get add => 'Add';
  @override
  String get search => 'Search';
  @override
  String get loading => 'Loading...';
  @override
  String get error => 'Error';
  @override
  String get success => 'Success';
  @override
  String get warning => 'Warning';
  @override
  String get info => 'Information';
  @override
  String get retry => 'Retry';
  @override
  String get close => 'Close';
  @override
  String get back => 'Back';
  @override
  String get next => 'Next';
  @override
  String get previous => 'Previous';
  @override
  String get done => 'Done';
  @override
  String get settings => 'Settings';
  @override
  String get profile => 'Profile';
  @override
  String get logout => 'Logout';
  @override
  String get login => 'Login';
  @override
  String get register => 'Register';
  @override
  String get forgotPassword => 'Forgot Password';
  @override
  String get changePassword => 'Change Password';
  @override
  String get confirmPassword => 'Confirm Password';
  @override
  String get email => 'Email';
  @override
  String get password => 'Password';
  @override
  String get username => 'Username';
  @override
  String get phone => 'Phone';
  @override
  String get address => 'Address';
  @override
  String get name => 'Name';
  @override
  String get firstName => 'First Name';
  @override
  String get lastName => 'Last Name';
  @override
  String get dateOfBirth => 'Date of Birth';
  @override
  String get gender => 'Gender';
  @override
  String get male => 'Male';
  @override
  String get female => 'Female';
  @override
  String get other => 'Other';

  // Navigation
  @override
  String get home => 'Home';
  @override
  String get timeTracking => 'Time Tracking';
  @override
  String get attendance => 'Attendance';
  @override
  String get reports => 'Reports';
  @override
  String get notifications => 'Notifications';
  @override
  String get help => 'Help';
  @override
  String get about => 'About';

  // Authentication
  @override
  String get welcomeBack => 'Welcome Back';
  @override
  String get signInToContinue => 'Sign in to continue';
  @override
  String get dontHaveAccount => "Don't have an account?";
  @override
  String get alreadyHaveAccount => 'Already have an account?';
  @override
  String get createAccount => 'Create Account';
  @override
  String get signIn => 'Sign In';
  @override
  String get signUp => 'Sign Up';
  @override
  String get signOut => 'Sign Out';
  @override
  String get forgotPasswordTitle => 'Forgot Password';
  @override
  String get forgotPasswordSubtitle => 'Enter your email to reset password';
  @override
  String get resetPassword => 'Reset Password';
  @override
  String get sendResetLink => 'Send Reset Link';
  @override
  String get backToLogin => 'Back to Login';
  @override
  String get passwordResetSent => 'Password reset link sent to your email';
  @override
  String get invalidCredentials => 'Invalid email or password';
  @override
  String get accountCreated => 'Account created successfully';
  @override
  String get loginSuccessful => 'Login successful';
  @override
  String get logoutSuccessful => 'Logout successful';

  // Home Screen
  @override
  String get goodMorning => 'Good Morning';
  @override
  String get goodAfternoon => 'Good Afternoon';
  @override
  String get goodEvening => 'Good Evening';
  @override
  String get todaySchedule => "Today's Schedule";
  @override
  String get recentTransactions => 'Recent Transactions';
  @override
  String get quickActions => 'Quick Actions';
  @override
  String get viewAll => 'View All';
  @override
  String get noDataAvailable => 'No data available';
  @override
  String get refreshData => 'Refresh Data';

  // Time Tracking
  @override
  String get checkIn => 'Check In';
  @override
  String get checkOut => 'Check Out';
  @override
  String get breakStart => 'Break Start';
  @override
  String get breakEnd => 'Break End';
  @override
  String get totalHours => 'Total Hours';
  @override
  String get workingHours => 'Working Hours';
  @override
  String get breakTime => 'Break Time';
  @override
  String get overtime => 'Overtime';
  @override
  String get location => 'Location';
  @override
  String get currentLocation => 'Current Location';
  @override
  String get workLocation => 'Work Location';
  @override
  String get timeTrackingHistory => 'Time Tracking History';
  @override
  String get todayActivity => 'Today Activity';
  @override
  String get thisWeek => 'This Week';
  @override
  String get thisMonth => 'This Month';
  @override
  String get selectDate => 'Select Date';
  @override
  String get selectTime => 'Select Time';

  // Biometric Attendance
  @override
  String get biometricAttendance => 'Biometric Attendance';
  @override
  String get fingerprintAuth => 'Fingerprint Authentication';
  @override
  String get faceIdAuth => 'Face ID Authentication';
  @override
  String get biometricNotAvailable => 'Biometric authentication not available';
  @override
  String get biometricNotEnrolled => 'No biometric data enrolled';
  @override
  String get authenticationFailed => 'Authentication failed';
  @override
  String get authenticationSuccessful => 'Authentication successful';
  @override
  String get selectEmployee => 'Select Employee';
  @override
  String get attendanceRecorded => 'Attendance recorded successfully';
  @override
  String get attendanceHistory => 'Attendance History';
  @override
  String get todaySummary => 'Today Summary';
  @override
  String get syncStatus => 'Sync Status';
  @override
  String get syncSuccessful => 'Sync successful';
  @override
  String get syncFailed => 'Sync failed';
  @override
  String get offlineMode => 'Offline Mode';
  @override
  String get onlineMode => 'Online Mode';

  // Settings
  @override
  String get generalSettings => 'General Settings';
  @override
  String get accountSettings => 'Account Settings';
  @override
  String get privacySettings => 'Privacy Settings';
  @override
  String get notificationSettings => 'Notification Settings';
  @override
  String get themeSettings => 'Theme Settings';
  @override
  String get languageSettings => 'Language Settings';
  @override
  String get securitySettings => 'Security Settings';
  @override
  String get dataSettings => 'Data Settings';
  @override
  String get aboutApp => 'About App';
  @override
  String get version => 'Version';
  @override
  String get buildNumber => 'Build Number';
  @override
  String get developer => 'Developer';
  @override
  String get contactSupport => 'Contact Support';
  @override
  String get rateApp => 'Rate App';
  @override
  String get shareApp => 'Share App';
  @override
  String get termsOfService => 'Terms of Service';
  @override
  String get privacyPolicy => 'Privacy Policy';

  // Theme Settings
  @override
  String get themeMode => 'Theme Mode';
  @override
  String get lightTheme => 'Light Theme';
  @override
  String get darkTheme => 'Dark Theme';
  @override
  String get systemTheme => 'System Theme';
  @override
  String get themeColor => 'Theme Color';
  @override
  String get blue => 'Blue';
  @override
  String get purple => 'Purple';
  @override
  String get green => 'Green';
  @override
  String get orange => 'Orange';
  @override
  String get red => 'Red';
  @override
  String get teal => 'Teal';
  @override
  String get preview => 'Preview';
  @override
  String get resetToDefaults => 'Reset to Defaults';
  @override
  String get themeResetConfirm =>
      'Are you sure you want to reset theme settings?';

  // Language Settings
  @override
  String get selectLanguage => 'Select Language';
  @override
  String get currentLanguage => 'Current Language';
  @override
  String get languageChanged => 'Language changed successfully';
  @override
  String get restartRequired => 'Restart app to apply changes';
  @override
  String get english => 'English';
  @override
  String get lao => 'ລາວ (Lao)';
  @override
  String get thai => 'ไทย (Thai)';
  @override
  String get chinese => '中文 (Chinese)';

  // Error Messages
  @override
  String get networkError => 'Network connection error';
  @override
  String get serverError => 'Server error occurred';
  @override
  String get unknownError => 'Unknown error occurred';
  @override
  String get validationError => 'Validation error';
  @override
  String get permissionDenied => 'Permission denied';
  @override
  String get locationPermissionDenied => 'Location permission denied';
  @override
  String get cameraPermissionDenied => 'Camera permission denied';
  @override
  String get storagePermissionDenied => 'Storage permission denied';
  @override
  String get biometricPermissionDenied => 'Biometric permission denied';
  @override
  String get sessionExpired => 'Session expired';
  @override
  String get accountLocked => 'Account locked';
  @override
  String get tooManyAttempts => 'Too many attempts';

  // Validation Messages
  @override
  String get fieldRequired => 'This field is required';
  @override
  String get invalidEmail => 'Invalid email address';
  @override
  String get passwordTooShort => 'Password must be at least 6 characters';
  @override
  String get passwordsDoNotMatch => 'Passwords do not match';
  @override
  String get invalidPhoneNumber => 'Invalid phone number';
  @override
  String get invalidDate => 'Invalid date';
  @override
  String get invalidTime => 'Invalid time';

  // Report Problem
  @override
  String get reportProblem => 'Report Problem';
  @override
  String get problemTitle => 'Problem Title';
  @override
  String get problemDescription => 'Problem Description';
  @override
  String get problemCategory => 'Problem Category';
  @override
  String get urgencyLevel => 'Urgency Level';
  @override
  String get low => 'Low';
  @override
  String get medium => 'Medium';
  @override
  String get high => 'High';
  @override
  String get critical => 'Critical';
  @override
  String get submitReport => 'Submit Report';
  @override
  String get reportSubmitted => 'Report submitted successfully';
  @override
  String get reportHistory => 'Report History';
  @override
  String get reportStatus => 'Report Status';
  @override
  String get pending => 'Pending';
  @override
  String get inProgress => 'In Progress';
  @override
  String get resolved => 'Resolved';
  @override
  String get closed => 'Closed';

  // Notifications
  @override
  String get newNotification => 'New Notification';
  @override
  String get markAsRead => 'Mark as Read';
  @override
  String get markAllAsRead => 'Mark All as Read';
  @override
  String get clearAll => 'Clear All';
  @override
  String get noNotifications => 'No notifications';
  @override
  String get pushNotifications => 'Push Notifications';
  @override
  String get emailNotifications => 'Email Notifications';
  @override
  String get smsNotifications => 'SMS Notifications';
  @override
  String get notificationSound => 'Notification Sound';
  @override
  String get vibration => 'Vibration';

  // Date and Time
  @override
  String get today => 'Today';
  @override
  String get yesterday => 'Yesterday';
  @override
  String get tomorrow => 'Tomorrow';
  @override
  String get thisWeekShort => 'This Week';
  @override
  String get lastWeek => 'Last Week';
  @override
  String get nextWeek => 'Next Week';
  @override
  String get thisMonthShort => 'This Month';
  @override
  String get lastMonth => 'Last Month';
  @override
  String get nextMonth => 'Next Month';
  @override
  String get thisYear => 'This Year';
  @override
  String get lastYear => 'Last Year';
  @override
  String get nextYear => 'Next Year';

  // Days of Week
  @override
  String get monday => 'Monday';
  @override
  String get tuesday => 'Tuesday';
  @override
  String get wednesday => 'Wednesday';
  @override
  String get thursday => 'Thursday';
  @override
  String get friday => 'Friday';
  @override
  String get saturday => 'Saturday';
  @override
  String get sunday => 'Sunday';

  // Months
  @override
  String get january => 'January';
  @override
  String get february => 'February';
  @override
  String get march => 'March';
  @override
  String get april => 'April';
  @override
  String get may => 'May';
  @override
  String get june => 'June';
  @override
  String get july => 'July';
  @override
  String get august => 'August';
  @override
  String get september => 'September';
  @override
  String get october => 'October';
  @override
  String get november => 'November';
  @override
  String get december => 'December';
}
