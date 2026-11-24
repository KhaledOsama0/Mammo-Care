import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({int totalPages = 3})
      : super(OnboardingState(totalPages: totalPages));

  void onPageChanged(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingKey, true);
    emit(state.copyWith(isCompleted: true));
  }
}
