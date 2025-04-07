import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';
import 'PaymentPage.dart'; // Import PaymentPage

void main() {
  runApp(PaymentMethods());
}

class PaymentMethods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primarybackground,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildStepCircle(true),
                  buildStepLine(),
                  buildStepCircle(true),
                  buildStepLine(),
                  buildStepCircle(true),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Types of Payment',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFFDE5902),
                    fontSize: 25,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildPaymentMethod(
                      imageUrl: 'assets/PayMethod/visa-logo.png',
                      title: 'Visa',
                      value: 'Visa',
                    ),
                    SizedBox(height: 20),
                    _buildPaymentMethod(
                      imageUrl: 'assets/PayMethod/instapay.jpg',
                      title: 'InstaPay',
                      value: 'InstaPay',
                    ),
                    SizedBox(height: 20),
                    _buildPaymentMethod(
                      imageUrl: 'assets/PayMethod/vodafone.jpg',
                      title: 'Vodafone cash',
                      value: 'Vodafone cash',
                    ),
                    SizedBox(height: 20),
                    _buildPaymentMethod(
                      imageUrl: 'assets/PayMethod/applepay.jpg',
                      title: 'Apple Pay',
                      value: 'Apple Pay',
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (selectedPaymentMethod != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a payment method'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDE5902),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    required String imageUrl,
    required String title,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selectedPaymentMethod == value
                ? Color(0xFFDE5902)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Radio<String>(
              value: value,
              groupValue: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue;
                });
              },
              activeColor: Color(0xFFDE5902),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget buildStepCircle(bool isActive) {
    return Container(
      width: isActive ? 25 : 18,
      height: isActive ? 25 : 18,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFDE5902) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget buildStepLine() {
    return Container(
      width: 100,
      height: 2,
      color: Color(0xFF317A8B),
    );
  }
}