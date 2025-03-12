// lib/app_styles.dart
import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primarybackground = Color(0xFF317a8b);
  static const Color backgroundColor = Color(0xFFF1F4F8);
  static const Color secondaryColor = Color(0xFF81C784);
  static const Color buttonColor = Color(0xFFde5902);
  static const Color fadedColor = Color(0xFF88e49d67);

  static const Color titleText = Color(0xFFde5902);
  static const Color textDark = Color(0xFF212121);
  static const Color textGrey = Color(0xFF57636C);
  static const Color textLight = Color(0xFFFFFFFF);

  // Text Styles
  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    color: textDark,
    height: 1.5,
  );

  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'Inter Tight',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: textLight,
    letterSpacing: -0.5,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: 'Inter Tight',
    fontSize: 35,
    fontWeight: FontWeight.w500,
    color: textLight,
  );

  static const TextStyle appBarGreeting = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: textLight,
  );


  // Button Styles
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    foregroundColor: textLight,
    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
    fixedSize: Size(280, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // Text Styles
  static TextStyle buttonTextStyle = const TextStyle(
    fontFamily: 'Inter Tight',
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );

  // Padding/Margin
  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets sectionPadding = EdgeInsets.symmetric(vertical: 24);

  // Add more styles as needed...
}
