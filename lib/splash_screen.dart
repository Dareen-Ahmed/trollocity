import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // لا نستخدم AppBar لتكون الشاشة ممتلئة
      body: Stack(
        fit: StackFit.expand, // ملء الشاشة بالكامل
        children: [
          // الخلفية باستخدام صورة من الإنترنت
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // استخدمي رابط صورة مباشر هنا، تأكدي أنه رابط صورة ينتهي بـ .jpg أو .png
                image: NetworkImage("https://th.bing.com/th/id/OIP.xEngHldELkBTZb1xo1xbFQAAAA?rs=1&pid=ImgDetMain"),
                fit: BoxFit.cover, // تملأ الشاشة مع قص الأجزاء الزائدة إذا لزم الأمر
              ),
            ),
          ),
          // طبقة شفافة لتوضيح النص
          Container(
            color: Colors.white54, // شفافية 50% باللون الأبيض
          ),
          // المحتوى (النصوص + الزر) في منتصف الشاشة
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min, // بحجم المحتوى فقط
              children: [
                // عنوان التطبيق
                Text(
                  "Trollocity",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 16),
                // النص الوصفي
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Say Goodbye to Long Queues, Hello to Smart Shopping!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // زر البدء
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    // عند الضغط، انتقل إلى شاشة إنشاء الحساب
                    Navigator.pushNamed(context, '/createAccount');
                  },
                  child: const Text(
                    "let's get started",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
