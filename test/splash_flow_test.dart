import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mammo_care/features/auth/presentation/screens/forgot_pass_screen.dart';
import 'package:mammo_care/features/auth/presentation/screens/login_screen.dart';
import 'package:mammo_care/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:mammo_care/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full Auth Navigation Flow Test', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MainApp());
    await tester.pump();

    // Advance past the splash delay to land on Onboarding
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Tap "Skip for now" on Onboarding
    final skipFinder = find.widgetWithText(TextButton, 'Skip for now');
    expect(skipFinder, findsOneWidget);
    await tester.tap(skipFinder);
    await tester.pumpAndSettle();

    // Verify LogInScreen is displayed
    expect(find.byType(LogInScreen), findsOneWidget);

    // Scroll down in LogInScreen to reveal footer
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    // Tap "Create an account" on LogInScreen
    final createAccountFinder =
        find.widgetWithText(TextButton, 'Create an account');
    expect(createAccountFinder, findsOneWidget);
    await tester.tap(createAccountFinder);
    await tester.pumpAndSettle();

    // Verify SignUpScreen is displayed
    expect(find.byType(SignUpScreen), findsOneWidget);

    // Tap Back button on SignUpScreen AppBar
    final backFinder = find.byTooltip('Back');
    expect(backFinder, findsOneWidget);
    await tester.tap(backFinder);
    await tester.pumpAndSettle();

    // Verify we are back on LogInScreen
    expect(find.byType(LogInScreen), findsOneWidget);

    // Tap "Forgot password?"
    final forgotFinder = find.widgetWithText(TextButton, 'Forgot password?');
    expect(forgotFinder, findsOneWidget);
    await tester.tap(forgotFinder);
    await tester.pumpAndSettle();

    // Verify ForgotPassScreen is displayed
    expect(find.byType(ForgotPassScreen), findsOneWidget);
  });
}
