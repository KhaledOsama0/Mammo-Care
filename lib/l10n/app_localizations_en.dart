// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Mammo Care';

  @override
  String get brandTagline => 'Your health, understood.';

  @override
  String get brandSubtitle =>
      'AI-supported cancer screening and compassionate follow-up care, all in one secure place.';

  @override
  String get onboardingTitle1 => 'Early Detection Saves Lives';

  @override
  String get onboardingBody1 =>
      'Regular screening and early detection are your most powerful tools against breast cancer.';

  @override
  String get onboardingTitle2 => 'Guidance for Every Step';

  @override
  String get onboardingBody2 =>
      'Track your scans, understand your results, and stay close to your care team.';

  @override
  String get onboardingTitle3 => 'Safe & Secure';

  @override
  String get onboardingBody3 =>
      'Your health data is encrypted and only accessible to you and your trusted providers.';

  @override
  String get continueButton => 'Continue';

  @override
  String get skipForNow => 'Skip for now';

  @override
  String get getStarted => 'Get Started';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInSubtitle => 'Sign in to continue your care journey.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get signIn => 'Sign in';

  @override
  String get newToApp => 'New to Mammo Care?';

  @override
  String get createAccount => 'Create an account';

  @override
  String get signOut => 'Sign out';

  @override
  String get fullName => 'Full name';

  @override
  String get fullNameHint => 'Enter your full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get confirmPasswordHint => 'Re-enter your password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordSubtitle =>
      'Enter your email to receive a reset link.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get navHome => 'Home';

  @override
  String get navReports => 'Reports';

  @override
  String get navDoctors => 'Doctors';

  @override
  String get navProfile => 'Profile';

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get goodAfternoon => 'Good afternoon,';

  @override
  String get goodEvening => 'Good evening,';

  @override
  String get nextAppointment => 'NEXT APPOINTMENT';

  @override
  String get quickActions => 'Quick actions';

  @override
  String get newAiScan => 'New AI scan';

  @override
  String get uploadAnImage => 'Upload an image';

  @override
  String get viewReports => 'View reports';

  @override
  String recentResults(int count) {
    return '$count recent results';
  }

  @override
  String get yourCarePlan => 'Your care plan';

  @override
  String get seeAll => 'See all';

  @override
  String get doingGreat => 'You\'re doing great';

  @override
  String tasksCompleted(int done, int total) {
    return '$done of $total tasks completed this week';
  }

  @override
  String get dailyNote => 'Daily note';

  @override
  String get yourHealthHistory => 'Your health history';

  @override
  String get securelyStored => 'Securely stored, easy to understand.';

  @override
  String get filterAll => 'All';

  @override
  String get filterAiScans => 'AI scans';

  @override
  String get filterClinical => 'Clinical';

  @override
  String get totalReports => 'Total reports';

  @override
  String get thisYear => 'This year';

  @override
  String get needAction => 'Need action';

  @override
  String get addExternalReport => 'Add an external report';

  @override
  String get statusLowConcern => 'Low concern';

  @override
  String get statusReviewed => 'Reviewed';

  @override
  String get statusNormalRange => 'Normal range';

  @override
  String get statusNeedAction => 'Need action';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get medicalOverview => 'MEDICAL OVERVIEW';

  @override
  String get verified => 'Verified';

  @override
  String get bloodType => 'Blood type';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get carePlan => 'Care plan';

  @override
  String get active => 'Active';

  @override
  String get careAndPreferences => 'CARE & PREFERENCES';

  @override
  String get healthInformation => 'Health information';

  @override
  String get conditionsAllergiesMeds => 'Conditions, allergies, medications';

  @override
  String get privacyConsent => 'Privacy & consent';

  @override
  String get controlDataUsage => 'Control how your data is used';

  @override
  String get notificationsTitle => 'NOTIFICATIONS';

  @override
  String get appointmentReminders => 'Appointment reminders';

  @override
  String get reportUpdates => 'Report updates';

  @override
  String appVersion(String version) {
    return 'Mammo Care · Version $version';
  }

  @override
  String get doctorsTitle => 'Doctors';

  @override
  String get searchDoctors => 'Search doctors...';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get aiScanTitle => 'New AI Scan';

  @override
  String get uploadImage => 'Upload Image';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get analyzeImage => 'Analyze Image';

  @override
  String get disclaimer =>
      'This AI scan is for informational purposes only and does not replace professional medical advice.';

  @override
  String get errorRequired => 'This field is required';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address';

  @override
  String get errorPasswordTooShort => 'Password must be at least 8 characters';

  @override
  String get errorPasswordsNotMatch => 'Passwords do not match';

  @override
  String get errorNetworkError =>
      'Network error. Please check your connection.';

  @override
  String get errorSomethingWrong => 'Something went wrong. Please try again.';

  @override
  String get errorInvalidCredentials => 'Invalid email or password.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System default';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get noData => 'No data available';

  @override
  String get patientId => 'Patient ID';
}
