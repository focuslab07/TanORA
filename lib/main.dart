import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'screens/main_navigation.dart';

void main() => runApp(const TanOraApp());

class TanOraApp extends StatelessWidget {
  const TanOraApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: AppColors.darkBg),
      home: const MainNavigation(),
    );
  }
}