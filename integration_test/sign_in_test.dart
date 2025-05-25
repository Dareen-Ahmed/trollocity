import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trollocity/main.dart' as app; // اسم الباكيج لديك
import 'package:firebase_core/firebase_core.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Sign in with invalid credentials shows error dialog', (WidgetTester tester) async {
    await Firebase.initializeApp();
    app.main();
    await tester.pumpAndSettle();

    // أدخل بريدًا إلكترونيًا وكلمة مرور غير صحيحة
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final signInButton = find.byKey(const Key('sign_in_button'));

    await tester.enterText(emailField, 'wrong@example.com');
    await tester.enterText(passwordField, 'invalidPassword123');
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // تحقق من ظهور Dialog الخطأ
    expect(find.textContaining('Sign-in failed'), findsOneWidget);
  });
}