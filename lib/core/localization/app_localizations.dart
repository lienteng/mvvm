import 'package:flutter/material.dart';

abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Common
  String get appName;
  String get ok;
  String get cancel;
  String get yes;
  String get no;
  String get save;
  String get delete;
  String get edit;
  String get add;
  String get search;
  String get loading;
  String get error;
  String get success;
  String get warning;
  String get info;
  String get retry;
  String get close;
  String get back;
  String get next;
  String get previous;
  String get done;
  String get settings;
  String get profile;
  String get logout;
  String get login;
  String get register;
  String get forgotPassword;
  String get changePassword;
  String get confirmPassword;
  String get email;
  String get password;
  String get username;
  String get phone;
  String get address;
  String get name;
  String get firstName;
  String get lastName;
  String get dateOfBirth;
  String get gender;
  String get male;
  String get female;
  String get other;

  // Navigation
  String get home;
  String get timeTracking;
  String get attendance;
  String get reports;
  String get notifications;
  String get help;
  String get about;

  // Authentication
  String get welcomeBack;
  String get signInToContinue;
  String get dontHaveAccount;
  String get alreadyHaveAccount;
  String get createAccount;
  String get signIn;
  String get signUp;
  String get signOut;
  String get forgotPasswordTitle;
  String get forgotPasswordSubtitle;
  String get resetPassword;
  String get sendResetLink;
  String get backToLogin;
  String get passwordResetSent;
  String get invalidCredentials;
  String get accountCreated;
  String get loginSuccessful;
  String get logoutSuccessful;

  // Home Screen
  String get goodMorning;
  String get goodAfternoon;
  String get goodEvening;
  String get todaySchedule;
  String get recentTransactions;
  String get quickActions;
  String get viewAll;
  String get noDataAvailable;
  String get refreshData;

  // Time Tracking
  String get checkIn;
  String get checkOut;
  String get breakStart;
  String get breakEnd;
  String get totalHours;
  String get workingHours;
  String get breakTime;
  String get overtime;
  String get location;
  String get currentLocation;
  String get workLocation;
  String get timeTrackingHistory;
  String get todayActivity;
  String get thisWeek;
  String get thisMonth;
  String get selectDate;
  String get selectTime;

  // Biometric Attendance
  String get biometricAttendance;
  String get fingerprintAuth;
  String get faceIdAuth;
  String get biometricNotAvailable;
  String get biometricNotEnrolled;
  String get authenticationFailed;
  String get authenticationSuccessful;
  String get selectEmployee;
  String get attendanceRecorded;
  String get attendanceHistory;
  String get todaySummary;
  String get syncStatus;
  String get syncSuccessful;
  String get syncFailed;
  String get offlineMode;
  String get onlineMode;

  // Settings
  String get generalSettings;
  String get accountSettings;
  String get privacySettings;
  String get notificationSettings;
  String get themeSettings;
  String get languageSettings;
  String get securitySettings;
  String get dataSettings;
  String get aboutApp;
  String get version;
  String get buildNumber;
  String get developer;
  String get contactSupport;
  String get rateApp;
  String get shareApp;
  String get termsOfService;
  String get privacyPolicy;

  // Theme Settings
  String get themeMode;
  String get lightTheme;
  String get darkTheme;
  String get systemTheme;
  String get themeColor;
  String get blue;
  String get purple;
  String get green;
  String get orange;
  String get red;
  String get teal;
  String get preview;
  String get resetToDefaults;
  String get themeResetConfirm;

  // Language Settings
  String get selectLanguage;
  String get currentLanguage;
  String get languageChanged;
  String get restartRequired;
  String get english;
  String get lao;
  String get thai;
  String get chinese;

  // Error Messages
  String get networkError;
  String get serverError;
  String get unknownError;
  String get validationError;
  String get permissionDenied;
  String get locationPermissionDenied;
  String get cameraPermissionDenied;
  String get storagePermissionDenied;
  String get biometricPermissionDenied;
  String get sessionExpired;
  String get accountLocked;
  String get tooManyAttempts;

  // Validation Messages
  String get fieldRequired;
  String get invalidEmail;
  String get passwordTooShort;
  String get passwordsDoNotMatch;
  String get invalidPhoneNumber;
  String get invalidDate;
  String get invalidTime;

  // Report Problem
  String get reportProblem;
  String get problemTitle;
  String get problemDescription;
  String get problemCategory;
  String get urgencyLevel;
  String get low;
  String get medium;
  String get high;
  String get critical;
  String get submitReport;
  String get reportSubmitted;
  String get reportHistory;
  String get reportStatus;
  String get pending;
  String get inProgress;
  String get resolved;
  String get closed;

  // Notifications
  String get newNotification;
  String get markAsRead;
  String get markAllAsRead;
  String get clearAll;
  String get noNotifications;
  String get pushNotifications;
  String get emailNotifications;
  String get smsNotifications;
  String get notificationSound;
  String get vibration;

  // Date and Time
  String get today;
  String get yesterday;
  String get tomorrow;
  String get thisWeekShort;
  String get lastWeek;
  String get nextWeek;
  String get thisMonthShort;
  String get lastMonth;
  String get nextMonth;
  String get thisYear;
  String get lastYear;
  String get nextYear;

  // Days of Week
  String get monday;
  String get tuesday;
  String get wednesday;
  String get thursday;
  String get friday;
  String get saturday;
  String get sunday;

  // Months
  String get january;
  String get february;
  String get march;
  String get april;
  String get may;
  String get june;
  String get july;
  String get august;
  String get september;
  String get october;
  String get november;
  String get december;
}
