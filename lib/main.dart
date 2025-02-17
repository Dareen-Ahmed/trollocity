import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'create_account_screen.dart';
import 'forgotpassword.dart';
import 'otp_screen.dart';
import 'change_password.dart';
import 'home.dart'; // Import HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/createAccount': (context) => const AuthScreen(),
        '/forgotPassword': (context) => const forgotpassword(),
        '/otp': (context) => const otp_screen(email: ''),
        '/changePassword': (context) => const change_password(),
        '/home': (context) => const home(), // Add HomeScreen to routes
      },
    );
  }
}
