// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // لا نستخدم AppBar لتكون الشاشة ممتلئة
//       body: Stack(
//         fit: StackFit.expand, // ملء الشاشة بالكامل
//         children: [
//           // الخلفية باستخدام صورة من الإنترنت
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 // استخدمي رابط صورة مباشر هنا، تأكدي أنه رابط صورة ينتهي بـ .jpg أو .png
//                 image: NetworkImage("https://th.bing.com/th/id/OIP.xEngHldELkBTZb1xo1xbFQAAAA?rs=1&pid=ImgDetMain"),
//                 fit: BoxFit.cover, // تملأ الشاشة مع قص الأجزاء الزائدة إذا لزم الأمر
//               ),
//             ),
//           ),
//           // طبقة شفافة لتوضيح النص
//           Container(
//             color: Colors.white54, // شفافية 50% باللون الأبيض
//           ),
//           // المحتوى (النصوص + الزر) في منتصف الشاشة
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // بحجم المحتوى فقط
//               children: [
//                 // عنوان التطبيق
//                 Text(
//                   "Trollocity",
//                   style: TextStyle(
//                     fontSize: 38,
//                     fontWeight: FontWeight.bold,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.black.withOpacity(0.8),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // النص الوصفي
//                 const Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30),
//                   child: Text(
//                     "Say Goodbye to Long Queues, Hello to Smart Shopping!",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 // زر البدء
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                   ),
//                   onPressed: () {
//                     // عند الضغط، انتقل إلى شاشة إنشاء الحساب
//                     Navigator.pushNamed(context, '/createAccount');
//                   },
//                   child: const Text(
//                     "let's get started",
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/Welcome.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.5),
                Colors.white,
              ],
              stops: [0, 0.6, 1],
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      '𝑻𝒓𝒐𝒍𝒍𝒐𝒄𝒊𝒕𝒚',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Text(
                      'Say Goodbye to Long Queues, Hello to Smart Shopping!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/createAccount');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDE5902),
                      minimumSize: const Size(250, 60),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "let's get started",
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
