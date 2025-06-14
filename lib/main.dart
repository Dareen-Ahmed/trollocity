import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'authentication/sign_in_screen.dart';
import 'authentication/forgotpassword.dart';
import 'authentication/create_account_screen.dart';
import 'provider/user_provider.dart';
import 'provider/cart_provider.dart';
import 'services/BluetoothService.dart';
import 'home.dart';
import 'market.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final bluetoothManager = BluetoothManager();
  await bluetoothManager.initBluetooth();

  runApp(
    ShowCaseWidget(
      builder: (context) => Builder(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CartProvider(bluetoothManager)),
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/createAccount': (context) => const CreateAccountScreen(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/home': (context) => const home(),
        '/market': (context) => const Market(),
        '/signIn': (context) => const SignInScreen(),
      },
      home: const AuthWrapper(), // ✅ استخدم AuthWrapper بدل SignInScreen مباشرةً
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // أثناء التحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // المستخدم مسجّل دخول
        if (snapshot.hasData && snapshot.data != null) {
          return const Market();
        }

        // المستخدم غير مسجّل
        return const SignInScreen();
      },
    );
  }
}
