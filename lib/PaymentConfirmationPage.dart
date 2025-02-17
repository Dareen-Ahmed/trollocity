import 'dart:async';
import 'package:flutter/material.dart';
import 'FeedbackPage.dart';


class PaymentConfirmationPage extends StatefulWidget {
  @override
  _PaymentConfirmationPageState createState() => _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage> {
  bool showFeedback = false;

  @override
  void initState() {
    super.initState();

    // Show feedback form after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showFeedback = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: showFeedback ? FeedbackPage() : PaymentSuccessWidget(),
      ),
    );
  }
}

// Payment Success Widget
class PaymentSuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network("https://m.media-amazon.com/images/S/aplus-seller-content-images-us-east-1/A2EUQ1WTGCTBG2/A22RBRPR1O6B1Q/9c117ca6-ae53-4d8a-82bf-ee22c77dc8b0._CR0,0,300,300_PT0_SX300__.png", width: 100),
        SizedBox(height: 20),
        Text("The payment has completed successfully", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
        SizedBox(height: 10),
        Text("Thank you for shopping with us", style: TextStyle(fontSize: 16)),
        Text("See you next time"),
      ],
    );
  }
}
