import 'package:flutter/material.dart';

class AppColors {
  // Dark Mode - Deep & Cozy
  static const darkBg = Color(0xFF0D0F14);
  static const darkGlass = Color(0x1AFFFFFF);

  // Light Mode - Soft & Airy
  static const lightBg = Color(0xFFF8F9FD);
  static const lightGlass = Color(0x1A000000);

  // Accents
  static const accentPurple = Color(0xFF9D8BFF);
  static const softOrange = Color(0xFFFFB38A);
  static const softRed = Color(0xFFFF8A8A);
}

class AppStyles {
  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: 26, 
    fontWeight: FontWeight.bold, 
    color: Theme.of(context).textTheme.titleLarge?.color,
  );

  static TextStyle cardTitle(BuildContext context) => TextStyle(
    fontSize: 17, 
    fontWeight: FontWeight.w600, 
    color: Theme.of(context).textTheme.titleLarge?.color,
  );
}