import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_constants.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashInitial());

  Future<void> init() async {
    emit(const SplashLoading());

    // Allow user to see branding animation (2.5 seconds)
    await Future.delayed(const Duration(milliseconds: 2500));

    try {
      final prefs = await SharedPreferences.getInstance();
      final hasCompletedOnboarding =
          prefs.getBool(AppConstants.onboardingKey) ?? false;

      if (!hasCompletedOnboarding) {
        emit(const SplashNavigating(SplashNavigationTarget.onboarding));
        return;
      }

      // Check user session
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
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
