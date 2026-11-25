import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';
import '../../../core/constants/app_constants.dart';
import '../model/user_model.dart';

class AuthRepository {
  final SupabaseClient? _client;

  AuthRepository({SupabaseClient? client}) : _client = client;

  SupabaseClient get client {
    if (_client != null) return _client;
    return SupabaseConfig.client;
  }

  User? get currentSupabaseUser {
    try {
      return client.auth.currentUser;
    } catch (_) {
      return null;
    }
  }

  Session? get currentSession {
    try {
      return client.auth.currentSession;
    } catch (_) {
      return null;
    }
  }

  bool get isAuthenticated {
    try {
      return currentSession != null;
    } catch (_) {
      return false;
    }
  }

  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  UserModel? get currentUser {
    final user = currentSupabaseUser;
    if (user == null) return null;
    return UserModel.fromSupabaseUser(user);
  }

  /// Sign In with Email and Password
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('User could not be found.');
      }

      return UserModel.fromSupabaseUser(user);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign Up with Email, Password, and User Metadata (First & Last Name)
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final fullName = '$firstName $lastName'.trim();

      final response = await client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'full_name': fullName,
        },
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Could not complete registration.');
      }

      // Try creating or syncing the profile in public.profiles table if it exists
      try {
        await client.from(AppConstants.profilesTable).upsert({
          'id': user.id,
          'email': user.email,
          'first_name': firstName.trim(),
          'last_name': lastName.trim(),
          'full_name': fullName,
          'updated_at': DateTime.now().toIso8601String(),
        });
      } catch (_) {
        // Silently ignore if profiles table schema differs or has triggers
      }

      return UserModel.fromSupabaseUser(user);
    } catch (e) {
      rethrow;
    }
  }

  /// Send Password Reset Email / Code
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(
        email.trim(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Update Password (when logged in or authenticated via reset token)
  Future<UserModel> updatePassword({required String newPassword}) async {
    try {
      final response = await client.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Failed to update password.');
      }

      return UserModel.fromSupabaseUser(user);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  /// Helper to convert Supabase auth exceptions to user-friendly messages
  static String formatErrorMessage(dynamic error, {bool isArabic = false}) {
    if (error is AuthException) {
      final message = error.message.toLowerCase();
      if (message.contains('invalid login credentials') ||
          message.contains('invalid_grant')) {
        return isArabic
            ? 'البريد الإلكتروني أو كلمة المرور غير صحيحة.'
            : 'Invalid email or password.';
      }
      if (message.contains('user already registered') ||
          message.contains('already exists')) {
        return isArabic
            ? 'يوجد حساب مسجل بهذا البريد الإلكتروني بالفعل.'
            : 'An account with this email already exists.';
      }
      if (message.contains('rate limit')) {
        return isArabic
            ? 'تم تجاوز الحد المسموح، يرجى الانتظار والمحاولة لاحقاً.'
            : 'Too many requests. Please wait a moment and try again.';
      }
      if (message.contains('network') || message.contains('socket')) {
        return isArabic
            ? 'تعذر الاتصال بالخادم، يرجى التأكد من اتصال الإنترنت.'
            : 'Network error. Please check your internet connection.';
      }
      return error.message;
    }

    return isArabic
        ? 'حدث خطأ غير متوقع، يرجى المحاولة لاحقاً.'
        : 'An unexpected error occurred. Please try again.';
  }
}
