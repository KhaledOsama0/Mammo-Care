import 'package:flutter_test/flutter_test.dart';
import 'package:mammo_care/features/auth/model/user_model.dart';
import 'package:mammo_care/features/auth/repository/auth_repository.dart';
import 'package:mammo_care/features/auth/view_model/auth_cubit.dart';
import 'package:mammo_care/features/auth/view_model/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class MockAuthRepository extends AuthRepository {
  UserModel? mockUser;
  bool mockIsAuthenticated = false;
  Exception? shouldThrow;

  @override
  UserModel? get currentUser => mockUser;

  @override
  bool get isAuthenticated => mockIsAuthenticated;

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockUser ??
        UserModel(
          id: 'mock-123',
          email: email,
          firstName: 'Sarah',
          lastName: 'Ahmed',
        );
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    if (shouldThrow != null) throw shouldThrow!;
    return UserModel(
      id: 'mock-new-id',
      email: email,
      firstName: firstName,
      lastName: lastName,
      fullName: '$firstName $lastName',
    );
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    if (shouldThrow != null) throw shouldThrow!;
  }

  @override
  Future<UserModel> updatePassword({required String newPassword}) async {
    if (shouldThrow != null) throw shouldThrow!;
    return mockUser ??
        const UserModel(
          id: 'mock-123',
          email: 'test@example.com',
        );
  }

  @override
  Future<void> signOut() async {
    if (shouldThrow != null) throw shouldThrow!;
    mockIsAuthenticated = false;
    mockUser = null;
  }
}

void main() {
  group('UserModel Unit Tests', () {
    test('displayName priority and fallback', () {
      const u1 = UserModel(
        id: '1',
        email: 'doctor@hospital.org',
        fullName: 'Dr. Jane Doe',
      );
      expect(u1.displayName, 'Dr. Jane Doe');

      const u2 = UserModel(
        id: '2',
        email: 'sarah.ahmed@example.com',
        firstName: 'Sarah',
        lastName: 'Ahmed',
      );
      expect(u2.displayName, 'Sarah Ahmed');

      const u3 = UserModel(
        id: '3',
        email: 'patient@clinic.com',
      );
      expect(u3.displayName, 'patient');
    });

    test('toJson and fromJson symmetry', () {
      final now = DateTime(2026, 1, 15, 10, 30);
      final user = UserModel(
        id: 'usr-999',
        email: 'test@mammo.care',
        firstName: 'Nour',
        lastName: 'Ali',
        fullName: 'Nour Ali',
        avatarUrl: 'https://cdn.example.com/photo.jpg',
        createdAt: now,
      );

      final json = user.toJson();
      final parsed = UserModel.fromJson(json);

      expect(parsed.id, user.id);
      expect(parsed.email, user.email);
      expect(parsed.firstName, user.firstName);
      expect(parsed.lastName, user.lastName);
      expect(parsed.fullName, user.fullName);
      expect(parsed.avatarUrl, user.avatarUrl);
      expect(parsed.createdAt, user.createdAt);
      expect(parsed, equals(user));
    });
  });

  group('AuthRepository Error Formatting', () {
    test('formats invalid credentials in AR and EN', () {
      const err = sp.AuthException('Invalid login credentials');
      expect(
        AuthRepository.formatErrorMessage(err, isArabic: false),
        'Invalid email or password.',
      );
      expect(
        AuthRepository.formatErrorMessage(err, isArabic: true),
        'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
      );
    });

    test('formats user already registered in AR and EN', () {
      const err = sp.AuthException('User already registered');
      expect(
        AuthRepository.formatErrorMessage(err, isArabic: false),
        'An account with this email already exists.',
      );
      expect(
        AuthRepository.formatErrorMessage(err, isArabic: true),
        'يوجد حساب مسجل بهذا البريد الإلكتروني بالفعل.',
      );
    });
  });

  group('AuthCubit MVVM Logic Tests', () {
    late MockAuthRepository mockRepo;
    late AuthCubit cubit;

    setUp(() {
      mockRepo = MockAuthRepository();
      cubit = AuthCubit(authRepository: mockRepo);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is AuthInitial', () {
      expect(cubit.state, const AuthInitial());
    });

    test('checkAuthStatus emits Unauthenticated when no session', () {
      mockRepo.mockIsAuthenticated = false;
      mockRepo.mockUser = null;

      cubit.checkAuthStatus();
      expect(cubit.state, const Unauthenticated());
    });

    test('checkAuthStatus emits Authenticated when session exists', () {
      const testUser = UserModel(id: '1', email: 'user@care.com');
      mockRepo.mockIsAuthenticated = true;
      mockRepo.mockUser = testUser;

      cubit.checkAuthStatus();
      expect(cubit.state, const Authenticated(testUser));
    });

    test('signIn success emits AuthLoading then Authenticated', () async {
      const testUser = UserModel(
        id: '100',
        email: 'user@care.com',
        firstName: 'Laila',
        lastName: 'Hassan',
      );
      mockRepo.mockUser = testUser;

      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.signIn(email: 'user@care.com', password: 'secretPassword');
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        const AuthLoading(),
        const Authenticated(testUser),
      ]);
    });

    test('signIn failure emits AuthLoading then AuthError', () async {
      mockRepo.shouldThrow =
          const sp.AuthException('Invalid login credentials');

      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.signIn(
        email: 'wrong@care.com',
        password: 'wrong',
        isArabic: true,
      );
      await Future<void>.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], const AuthLoading());
      expect(states[1], isA<AuthError>());
      final error = states[1] as AuthError;
      expect(error.message, 'البريد الإلكتروني أو كلمة المرور غير صحيحة.');
    });

    test('signUp emits AuthSignUpSuccess when awaiting confirmation', () async {
      mockRepo.mockIsAuthenticated = false;

      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.signUp(
        email: 'newuser@care.com',
        password: 'validPassword123',
        firstName: 'Mona',
        lastName: 'Zaki',
      );
      await Future<void>.delayed(Duration.zero);

      expect(states.length, 2);
      expect(states[0], const AuthLoading());
      expect(states[1], isA<AuthSignUpSuccess>());
      final success = states[1] as AuthSignUpSuccess;
      expect(success.user.email, 'newuser@care.com');
      expect(success.needsEmailConfirmation, true);
    });

    test('sendPasswordReset emits PasswordResetSent', () async {
      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.sendPasswordReset(email: 'reset@care.com');
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        const AuthLoading(),
        const PasswordResetSent('reset@care.com'),
      ]);
    });

    test('updatePassword emits PasswordUpdated', () async {
      const user = UserModel(id: '100', email: 'reset@care.com');
      mockRepo.mockUser = user;

      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.updatePassword(newPassword: 'newSecretPassword123');
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        const AuthLoading(),
        const PasswordUpdated(user),
      ]);
    });

    test('signOut emits Unauthenticated', () async {
      mockRepo.mockIsAuthenticated = true;

      final states = <AuthState>[];
      cubit.stream.listen(states.add);

      await cubit.signOut();
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        const AuthLoading(),
        const Unauthenticated(),
      ]);
    });
  });
}
