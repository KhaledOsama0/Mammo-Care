import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import '../../auth/repository/auth_repository.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository _authRepository;

  SplashCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository(),
        super(const SplashInitial());

  Future<void> init({bool forceShowOnboarding = true}) async {
    emit(const SplashLoading());

    // Allow user to see branding animation (2.5 seconds)
    await Future.delayed(const Duration(milliseconds: 2500));

    try {
      // دائماً الانتقال إلى الـ Onboarding لعرض التدفق كاملاً للدكتور
      if (forceShowOnboarding) {
        emit(const SplashNavigating(SplashNavigationTarget.onboarding));
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final hasCompletedOnboarding =
          prefs.getBool(AppConstants.onboardingKey) ?? false;

      if (!hasCompletedOnboarding) {
        emit(const SplashNavigating(SplashNavigationTarget.onboarding));
        return;
      }

      // Check user session safely
      if (_authRepository.isAuthenticated) {
        emit(const SplashNavigating(SplashNavigationTarget.home));
      } else {
        emit(const SplashNavigating(SplashNavigationTarget.login));
      }
    } catch (_) {
      // Fallback to onboarding if anything goes wrong
      emit(const SplashNavigating(SplashNavigationTarget.onboarding));
    }
  }
}
