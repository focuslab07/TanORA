import 'package:flutter/material.dart';

class AppColors {
  static const primaryBg = Color(0xFF0D0F14);
  static const darkBg = Color(0xFF0D0F14); // Added for navigation compatibility
  static const accentPurple = Color(0xFF9D8BFF);
  static const glassWhite = Color(0x1AFFFFFF);
}

class AppStyles {
  static const heading = TextStyle(
    fontSize: 24, 
    fontWeight: FontWeight.bold, 
    color: Colors.white,
  );

  static const subHeading = TextStyle(
    fontSize: 14, 
    color: Colors.white70,
  );

  static const cardTitle = TextStyle(
    fontSize: 16, 
    fontWeight: FontWeight.w600, 
    color: Colors.white,
  );
}