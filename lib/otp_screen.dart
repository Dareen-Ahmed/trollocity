import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لاستيراد الـ inputFormatters
import 'change_password.dart';
import 'market.dart'; // Import the MarketChooserScreen

class otp_screen extends StatefulWidget {
  const otp_screen({super.key, required this.email});

  final String email;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<otp_screen> {
  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());
  bool isButtonEnabled = false; // متغير لتفعيل الزر

  void checkOtpCompletion() {
    // التحقق مما إذا كانت جميع الحقول ممتلئة
    bool allFilled = controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      isButtonEnabled = allFilled; // تحديث حالة الزر
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF317A8B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Verification Code",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please enter the OTP sent to your registered email to complete your verification.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    autofocus: index == 0, // يجعل الحقل الأول نشط تلقائيًا
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: "",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // يقبل الأرقام فقط
                    ],
                    onChanged: (value) {
                      checkOtpCompletion(); // تحديث حالة الزر عند الإدخال
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus(); // انتقال تلقائي للحقل التالي
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus(); // الرجوع للخلف عند الحذف
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () {
                // Navigate to MarketChooserScreen after OTP verification
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const market(),
                  ),
                );
              }
                  : null, // تعطيل الزر إذا لم يتم إدخال جميع الأرقام
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Let's Get Started",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}