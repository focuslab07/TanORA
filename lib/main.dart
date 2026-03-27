import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'core/quotes_data.dart';
import 'models/task_model.dart';
import 'screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load all persistent data before showing the UI
  await QuotesData.loadPersistentData(); 
  await TaskStorage.loadFromPhone();
  
  runApp(const TanOraApp());
}

class TanOraApp extends StatelessWidget {
  const TanOraApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0F14),
      ),
      home: const MainNavigation(),
    );
  }
}