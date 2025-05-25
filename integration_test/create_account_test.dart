import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trollocity/main.dart' as app;

void main() {
  testWidgets('Navigate to Create Account and fill the form', (WidgetTester tester) async {
    // شغّل التطبيق
    app.main();
    await tester.pumpAndSettle();

    // تأكد من ظهور شاشة تسجيل الدخول
    expect(find.text("Don't have an account? Create one"), findsOneWidget);

    // اضغط على زر "Don't have an account? Create one"
    await tester.tap(find.text("Don't have an account? Create one"));
    await tester.pumpAndSettle();

    // تحقق من الانتقال إلى صفحة إنشاء الحساب
    expect(find.text("Create Account"), findsOneWidget);

    // العثور على الحقول باستخدام الـ Keys
    final nameField = find.byKey(const Key('name_field'));
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final signUpButton = find.byKey(const Key('sign_up_button'));

    // املأ الحقول
    await tester.enterText(nameField, 'Test User');
    await tester.enterText(emailField, 'testuser@example.com');
    await tester.enterText(passwordField, 'TestPass123');

    // اضغط على زر إنشاء الحساب
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // تحقق من وجود Dialog التحقق من البريد (حسب النص الظاهر)
    expect(find.textContaining('verification email'), findsOneWidget);
  });
}
