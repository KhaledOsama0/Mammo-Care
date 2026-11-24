import 'package:equatable/equatable.dart';

enum SplashNavigationTarget {
  onboarding,
  login,
  home,
}

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {
  const SplashInitial();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashNavigating extends SplashState {
  final SplashNavigationTarget target;

  const SplashNavigating(this.target);

  @override
  List<Object?> get props => [target];
}
