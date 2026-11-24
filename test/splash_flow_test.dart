import 'package:flutter_test/flutter_test.dart';
import 'package:mammo_care/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Splash navigates to Onboarding without exceptions', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MainApp());
    await tester.pump();

    // Advance 3 seconds past the splash delay
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();
  });
}
