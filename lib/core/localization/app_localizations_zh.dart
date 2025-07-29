import 'app_localizations.dart';

class AppLocalizationsZh extends AppLocalizations {
  @override
  String get appName => 'Flutter MVVM 应用';

  // Common
  @override
  String get ok => '确定';
  @override
  String get cancel => '取消';
  @override
  String get yes => '是';
  @override
  String get no => '否';
  @override
  String get save => '保存';
  @override
  String get delete => '删除';
  @override
  String get edit => '编辑';
  @override
  String get add => '添加';
  @override
  String get search => '搜索';
  @override
  String get loading => '加载中...';
  @override
  String get error => '错误';
  @override
  String get success => '成功';
  @override
  String get warning => '警告';
  @override
  String get info => '信息';
  @override
  String get retry => '重试';
  @override
  String get close => '关闭';
  @override
  String get back => '返回';
  @override
  String get next => '下一步';
  @override
  String get previous => '上一步';
  @override
  String get done => '完成';
  @override
  String get settings => '设置';
  @override
  String get profile => '个人资料';
  @override
  String get logout => '退出登录';
  @override
  String get login => '登录';
  @override
  String get register => '注册';
  @override
  String get forgotPassword => '忘记密码';
  @override
  String get changePassword => '更改密码';
  @override
  String get confirmPassword => '确认密码';
  @override
  String get email => '邮箱';
  @override
  String get password => '密码';
  @override
  String get username => '用户名';
  @override
  String get phone => '电话';
  @override
  String get address => '地址';
  @override
  String get name => '姓名';
  @override
  String get firstName => '名';
  @override
  String get lastName => '姓';
  @override
  String get dateOfBirth => '出生日期';
  @override
  String get gender => '性别';
  @override
  String get male => '男';
  @override
  String get female => '女';
  @override
  String get other => '其他';

  // Navigation
  @override
  String get home => '首页';
  @override
  String get timeTracking => '时间跟踪';
  @override
  String get attendance => '考勤';
  @override
  String get reports => '报告';
  @override
  String get notifications => '通知';
  @override
  String get help => '帮助';
  @override
  String get about => '关于';

  // Authentication
  @override
  String get welcomeBack => '欢迎回来';
  @override
  String get signInToContinue => '登录以继续';
  @override
  String get dontHaveAccount => '还没有账户？';
  @override
  String get alreadyHaveAccount => '已有账户？';
  @override
  String get createAccount => '创建账户';
  @override
  String get signIn => '登录';
  @override
  String get signUp => '注册';
  @override
  String get signOut => '退出';
  @override
  String get forgotPasswordTitle => '忘记密码';
  @override
  String get forgotPasswordSubtitle => '输入邮箱重置密码';
  @override
  String get resetPassword => '重置密码';
  @override
  String get sendResetLink => '发送重置链接';
  @override
  String get backToLogin => '返回登录';
  @override
  String get passwordResetSent => '密码重置链接已发送到您的邮箱';
  @override
  String get invalidCredentials => '邮箱或密码无效';
  @override
  String get accountCreated => '账户创建成功';
  @override
  String get loginSuccessful => '登录成功';
  @override
  String get logoutSuccessful => '退出成功';

  // Home Screen
  @override
  String get goodMorning => '早上好';
  @override
  String get goodAfternoon => '下午好';
  @override
  String get goodEvening => '晚上好';
  @override
  String get todaySchedule => '今日日程';
  @override
  String get recentTransactions => '最近交易';
  @override
  String get quickActions => '快速操作';
  @override
  String get viewAll => '查看全部';
  @override
  String get noDataAvailable => '暂无数据';
  @override
  String get refreshData => '刷新数据';

  // Time Tracking
  @override
  String get checkIn => '签到';
  @override
  String get checkOut => '签退';
  @override
  String get breakStart => '开始休息';
  @override
  String get breakEnd => '结束休息';
  @override
  String get totalHours => '总小时数';
  @override
  String get workingHours => '工作小时';
  @override
  String get breakTime => '休息时间';
  @override
  String get overtime => '加班时间';
  @override
  String get location => '位置';
  @override
  String get currentLocation => '当前位置';
  @override
  String get workLocation => '工作地点';
  @override
  String get timeTrackingHistory => '时间跟踪历史';
  @override
  String get todayActivity => '今日活动';
  @override
  String get thisWeek => '本周';
  @override
  String get thisMonth => '本月';
  @override
  String get selectDate => '选择日期';
  @override
  String get selectTime => '选择时间';

  // Biometric Attendance
  @override
  String get biometricAttendance => '生物识别考勤';
  @override
  String get fingerprintAuth => '指纹认证';
  @override
  String get faceIdAuth => '面部识别认证';
  @override
  String get biometricNotAvailable => '生物识别认证不可用';
  @override
  String get biometricNotEnrolled => '未录入生物识别数据';
  @override
  String get authenticationFailed => '认证失败';
  @override
  String get authenticationSuccessful => '认证成功';
  @override
  String get selectEmployee => '选择员工';
  @override
  String get attendanceRecorded => '考勤记录成功';
  @override
  String get attendanceHistory => '考勤历史';
  @override
  String get todaySummary => '今日总结';
  @override
  String get syncStatus => '同步状态';
  @override
  String get syncSuccessful => '同步成功';
  @override
  String get syncFailed => '同步失败';
  @override
  String get offlineMode => '离线模式';
  @override
  String get onlineMode => '在线模式';

  // Settings
  @override
  String get generalSettings => '常规设置';
  @override
  String get accountSettings => '账户设置';
  @override
  String get privacySettings => '隐私设置';
  @override
  String get notificationSettings => '通知设置';
  @override
  String get themeSettings => '主题设置';
  @override
  String get languageSettings => '语言设置';
  @override
  String get securitySettings => '安全设置';
  @override
  String get dataSettings => '数据设置';
  @override
  String get aboutApp => '关于应用';
  @override
  String get version => '版本';
  @override
  String get buildNumber => '构建号';
  @override
  String get developer => '开发者';
  @override
  String get contactSupport => '联系支持';
  @override
  String get rateApp => '评价应用';
  @override
  String get shareApp => '分享应用';
  @override
  String get termsOfService => '服务条款';
  @override
  String get privacyPolicy => '隐私政策';

  // Theme Settings
  @override
  String get themeMode => '主题模式';
  @override
  String get lightTheme => '浅色主题';
  @override
  String get darkTheme => '深色主题';
  @override
  String get systemTheme => '系统主题';
  @override
  String get themeColor => '主题颜色';
  @override
  String get blue => '蓝色';
  @override
  String get purple => '紫色';
  @override
  String get green => '绿色';
  @override
  String get orange => '橙色';
  @override
  String get red => '红色';
  @override
  String get teal => '青色';
  @override
  String get preview => '预览';
  @override
  String get resetToDefaults => '重置为默认';
  @override
  String get themeResetConfirm => '确定要重置主题设置吗？';

  // Language Settings
  @override
  String get selectLanguage => '选择语言';
  @override
  String get currentLanguage => '当前语言';
  @override
  String get languageChanged => '语言更改成功';
  @override
  String get restartRequired => '需要重启应用以应用更改';
  @override
  String get english => 'English (英语)';
  @override
  String get lao => 'ລາວ (老挝语)';
  @override
  String get thai => 'ไทย (泰语)';
  @override
  String get chinese => '中文';

  // Error Messages
  @override
  String get networkError => '网络连接错误';
  @override
  String get serverError => '服务器错误';
  @override
  String get unknownError => '未知错误';
  @override
  String get validationError => '验证错误';
  @override
  String get permissionDenied => '权限被拒绝';
  @override
  String get locationPermissionDenied => '位置权限被拒绝';
  @override
  String get cameraPermissionDenied => '相机权限被拒绝';
  @override
  String get storagePermissionDenied => '存储权限被拒绝';
  @override
  String get biometricPermissionDenied => '生物识别权限被拒绝';
  @override
  String get sessionExpired => '会话已过期';
  @override
  String get accountLocked => '账户已锁定';
  @override
  String get tooManyAttempts => '尝试次数过多';

  // Validation Messages
  @override
  String get fieldRequired => '此字段为必填项';
  @override
  String get invalidEmail => '邮箱格式无效';
  @override
  String get passwordTooShort => '密码至少需要6个字符';
  @override
  String get passwordsDoNotMatch => '密码不匹配';
  @override
  String get invalidPhoneNumber => '电话号码无效';
  @override
  String get invalidDate => '日期无效';
  @override
  String get invalidTime => '时间无效';

  // Report Problem
  @override
  String get reportProblem => '报告问题';
  @override
  String get problemTitle => '问题标题';
  @override
  String get problemDescription => '问题描述';
  @override
  String get problemCategory => '问题类别';
  @override
  String get urgencyLevel => '紧急程度';
  @override
  String get low => '低';
  @override
  String get medium => '中';
  @override
  String get high => '高';
  @override
  String get critical => '紧急';
  @override
  String get submitReport => '提交报告';
  @override
  String get reportSubmitted => '报告提交成功';
  @override
  String get reportHistory => '报告历史';
  @override
  String get reportStatus => '报告状态';
  @override
  String get pending => '待处理';
  @override
  String get inProgress => '处理中';
  @override
  String get resolved => '已解决';
  @override
  String get closed => '已关闭';

  // Notifications
  @override
  String get newNotification => '新通知';
  @override
  String get markAsRead => '标记为已读';
  @override
  String get markAllAsRead => '全部标记为已读';
  @override
  String get clearAll => '清除全部';
  @override
  String get noNotifications => '暂无通知';
  @override
  String get pushNotifications => '推送通知';
  @override
  String get emailNotifications => '邮件通知';
  @override
  String get smsNotifications => '短信通知';
  @override
  String get notificationSound => '通知声音';
  @override
  String get vibration => '振动';

  // Date and Time
  @override
  String get today => '今天';
  @override
  String get yesterday => '昨天';
  @override
  String get tomorrow => '明天';
  @override
  String get thisWeekShort => '本周';
  @override
  String get lastWeek => '上周';
  @override
  String get nextWeek => '下周';
  @override
  String get thisMonthShort => '本月';
  @override
  String get lastMonth => '上月';
  @override
  String get nextMonth => '下月';
  @override
  String get thisYear => '今年';
  @override
  String get lastYear => '去年';
  @override
  String get nextYear => '明年';

  // Days of Week
  @override
  String get monday => '星期一';
  @override
  String get tuesday => '星期二';
  @override
  String get wednesday => '星期三';
  @override
  String get thursday => '星期四';
  @override
  String get friday => '星期五';
  @override
  String get saturday => '星期六';
  @override
  String get sunday => '星期日';

  // Months
  @override
  String get january => '一月';
  @override
  String get february => '二月';
  @override
  String get march => '三月';
  @override
  String get april => '四月';
  @override
  String get may => '五月';
  @override
  String get june => '六月';
  @override
  String get july => '七月';
  @override
  String get august => '八月';
  @override
  String get september => '九月';
  @override
  String get october => '十月';
  @override
  String get november => '十一月';
  @override
  String get december => '十二月';
}
