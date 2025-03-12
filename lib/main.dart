import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'create_account_screen.dart';
import 'ForgotPassword.dart';
import 'home.dart';
import 'market.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial screen
      routes: {
        '/': (context) => const SplashScreen(),
        '/createAccount': (context) => const AuthScreen(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/home': (context) => const home(), // HomeScreen
        '/markets': (context) => const market(), // MarketScreen

      },
    );
  }
}
