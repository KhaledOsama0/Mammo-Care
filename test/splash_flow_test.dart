import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mammo_care/features/auth/presentation/screens/login_screen.dart';
import 'package:mammo_care/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Splash navigates to Onboarding and then to LogInScreen',
      (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MainApp());
    await tester.pump();

    // Advance 3 seconds past the splash delay to land on Onboarding
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    // Find "Skip for now" text button and tap it
    final skipFinder = find.widgetWithText(TextButton, 'Skip for now');
    expect(skipFinder, findsOneWidget);
    await tester.tap(skipFinder);
    await tester.pumpAndSettle();

    // Verify LogInScreen is displayed!
    expect(find.byType(LogInScreen), findsOneWidget);
  });
}
