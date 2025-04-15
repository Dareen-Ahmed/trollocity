import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/forgotpassword.dart';
import 'cart/provider/provider.dart';
import 'services/BluetoothService.dart';
import 'splash_screen.dart';
import 'authentication/create_account_screen.dart';
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

  runApp(MultiProvider(providers: [
    // Provider(create: (context)=> CartProvider()),
    ChangeNotifierProvider(
      create: (_) => CartProvider(BluetoothManager()),
    ),
  ], child: const MyApp()));
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
        '/home': (context) => const home(),
        '/markets': (context) => const market(),
      },
    );
  }
}
