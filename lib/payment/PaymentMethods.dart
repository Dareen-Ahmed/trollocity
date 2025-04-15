import 'package:flutter/material.dart';
import 'package:graduation/app_styles.dart';

import 'PaymentPage.dart';

class PaymentMethods extends StatelessWidget {
  final List items;

  const PaymentMethods({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaymentScreen(items: items),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  final List items;

  const PaymentScreen({required this.items, Key? key}) : super(key: key);

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
          padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStepCircle(true),
                  _buildStepLine(),
                  _buildStepCircle(true),
                  _buildStepLine(),
                  _buildStepCircle(true),
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
              SizedBox(height: 20),
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
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
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
          Radio(
            value: value,
            groupValue: selectedPaymentMethod,
            onChanged: (String? val) {
              setState(() {
                selectedPaymentMethod = val;
              });
            },
            activeColor: Color(0xFFDE5902),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(bool filled) {
    return Container(
      width: filled ? 25 : 18,
      height: filled ? 25 : 18,
      decoration: BoxDecoration(
        color: Color(0xFFDE5902),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 100,
      height: 2,
      color: Color(0xFF317A8B),
    );
  }
}

