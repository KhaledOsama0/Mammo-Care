import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const AuthInitial());

  AuthRepository get repository => _authRepository;

  UserModel? get currentUser => _authRepository.currentUser;

  bool get isAuthenticated => _authRepository.isAuthenticated;

  /// Check whether the user currently has an active session
  void checkAuthStatus() {
    final user = _authRepository.currentUser;
    if (_authRepository.isAuthenticated && user != null) {
      emit(Authenticated(user));
    } else {
      emit(const Unauthenticated());
    }
  }

  /// Sign In with Email & Password
  Future<void> signIn({
    required String email,
    required String password,
    bool isArabic = false,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.signIn(
        email: email,
        password: password,
      );
      emit(Authenticated(user));
    } catch (e) {
      final errorMessage = AuthRepository.formatErrorMessage(e, isArabic: isArabic);
      emit(AuthError(message: errorMessage, error: e));
    }
  }

  /// Sign Up with Email, Password, First & Last Name
  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    bool isArabic = false,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.signUp(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      );

      final hasSession = _authRepository.isAuthenticated;
      if (hasSession) {
        emit(Authenticated(user));
      } else {
        emit(AuthSignUpSuccess(
          user: user,
          needsEmailConfirmation: true,
        ));
      }
    } catch (e) {
      final errorMessage = AuthRepository.formatErrorMessage(e, isArabic: isArabic);
      emit(AuthError(message: errorMessage, error: e));
    }
  }

  /// Send password reset email
  Future<void> sendPasswordReset({
    required String email,
    bool isArabic = false,
  }) async {
    emit(const AuthLoading());
    try {
      await _authRepository.sendPasswordResetEmail(email: email);
      emit(PasswordResetSent(email.trim()));
    } catch (e) {
      final errorMessage = AuthRepository.formatErrorMessage(e, isArabic: isArabic);
      emit(AuthError(message: errorMessage, error: e));
    }
  }

  /// Update password
  Future<void> updatePassword({
    required String newPassword,
    bool isArabic = false,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _authRepository.updatePassword(newPassword: newPassword);
      emit(PasswordUpdated(user));
    } catch (e) {
      final errorMessage = AuthRepository.formatErrorMessage(e, isArabic: isArabic);
      emit(AuthError(message: errorMessage, error: e));
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    emit(const AuthLoading());
    try {
      await _authRepository.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString(), error: e));
    }
  }

  /// Reset auth state to initial (e.g. when dismissing error or leaving flow)
  void resetState() {
    emit(const AuthInitial());
  }
}
