
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trollocity/app_styles.dart';
import 'FeedbackPage.dart';

class PaymentConfirmationPage extends StatefulWidget {
  @override
  _PaymentConfirmationPageState createState() =>
      _PaymentConfirmationPageState();
}

class _PaymentConfirmationPageState extends State<PaymentConfirmationPage>
    with TickerProviderStateMixin {
  bool showFeedback = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 40.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _controller.forward();

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: SafeArea(
        child: Center(
          child: showFeedback
              ? FeedbackPage()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Progress Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Color(0xFFDE5902),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color(0xFF317A8B),
                          ),
                        ),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Color(0xFFDE5902),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 2,
                          decoration: BoxDecoration(
                            color: Color(0xFF317A8B),
                          ),
                        ),
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Color(0xFFDE5902),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),

                    // Animated Check Icon
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Color(0x4CEF9239),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF317A8B),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: Color(0xFF317A8B),
                            size: 90,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Animated Text: Payment Success
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'The payment has completed successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            color: Color(0xFFDE5902),
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Animated Text: Thank You
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'Thank you for shopping with us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter Tight',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Animated Text: See You Next Time
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          'See you next time',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
