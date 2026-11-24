abstract class AppConstants {
  // App Info
  static const String appName = 'Mammo Care';
  static const String appVersion = '1.0.0';

  // Supabase Tables
  static const String profilesTable = 'profiles';
  static const String reportsTable = 'reports';
  static const String appointmentsTable = 'appointments';
  static const String doctorsTable = 'doctors';
  static const String carePlanTasksTable = 'care_plan_tasks';

  // Storage Buckets
  static const String reportsBucket = 'reports';
  static const String avatarsBucket = 'avatars';
  static const String scansBucket = 'scans';

  // Shared Preferences Keys
  static const String localeKey = 'app_locale';
  static const String themeKey = 'app_theme';
  static const String onboardingKey = 'onboarding_done';
}
