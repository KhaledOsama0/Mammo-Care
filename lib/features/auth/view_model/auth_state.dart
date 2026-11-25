import 'package:equatable/equatable.dart';
import '../model/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial auth state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Loading indicator during async auth calls
class AuthLoading extends AuthState {
  final String? message;
  const AuthLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// User is authenticated with a valid session
class Authenticated extends AuthState {
  final UserModel user;
  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// User is not logged in
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Sign up completed successfully (either immediately logged in or awaiting email confirmation)
class AuthSignUpSuccess extends AuthState {
  final UserModel user;
  final bool needsEmailConfirmation;

  const AuthSignUpSuccess({
    required this.user,
    required this.needsEmailConfirmation,
  });

  @override
  List<Object?> get props => [user, needsEmailConfirmation];
}

/// Password reset email has been dispatched
class PasswordResetSent extends AuthState {
  final String email;
  const PasswordResetSent(this.email);

  @override
  List<Object?> get props => [email];
}

/// Password was successfully updated
class PasswordUpdated extends AuthState {
  final UserModel user;
  const PasswordUpdated(this.user);

  @override
  List<Object?> get props => [user];
}

/// An error occurred during an auth action
class AuthError extends AuthState {
  final String message;
  final dynamic error;

  const AuthError({required this.message, this.error});

  @override
  List<Object?> get props => [message, error];
}
