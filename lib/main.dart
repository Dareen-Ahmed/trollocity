import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication/sign_in_screen.dart'; // تم تعديل المسار إلى SignInScreen
import 'authentication/forgotpassword.dart';
import 'provider/user_provider.dart';
import 'provider/cart_provider.dart';
import 'services/BluetoothService.dart';
import 'splash_screen.dart';
import 'authentication/create_account_screen.dart'; // صفحة إنشاء الحساب
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

  final bluetoothManager = BluetoothManager(); // Initialize BluetoothManager
  await bluetoothManager.initBluetooth();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider(bluetoothManager),),
      ChangeNotifierProvider(create: (_) => UserProvider(),),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(), // ✅ عرض شاشة تسجيل الدخول مباشرة
      routes: {
        '/createAccount': (context) => const CreateAccountScreen(),
        '/forgotPassword': (context) => const ForgotPassword(),
        '/home': (context) => const home(),
        '/market': (context) => const Market(),
        '/signIn': (context) => const SignInScreen(),
      },
    );
  }
}

