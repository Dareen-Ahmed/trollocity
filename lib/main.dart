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
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      // ✅ تحميل بيانات المستخدم عند بداية التطبيق
      await Provider.of<UserProvider>(context, listen: false).fetchUserData(user.uid);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      return const Market(); // ✅ المستخدم داخل التطبيق
    }

    return const SignInScreen(); // ✅ المستخدم مش مسجّل دخول
  }
}
