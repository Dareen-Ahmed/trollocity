import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _handleStartButton(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      // المستخدم مسجّل دخول ومحقق من بريده
      Navigator.pushReplacementNamed(context, '/market');
    } else {
      // المستخدم غير مسجّل دخول
      Navigator.pushReplacementNamed(context, '/signIn');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Welcome.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withOpacity(0.5),
                Colors.white,
              ],
              stops: const [0, 0.6, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 80),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      '𝑻𝒓𝒐𝒍𝒍𝒐𝒄𝒊𝒕𝒚',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Text(
                      'Say Goodbye to Long Queues, Hello to Smart Shopping!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    key: const Key('get_started_button'), // ✅ أضف هذا المفتاح
                    onPressed: () => _handleStartButton(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDE5902),
                      minimumSize: const Size(250, 60),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Let's Get Started",
                      style: TextStyle(
                        fontFamily: 'Inter Tight',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
