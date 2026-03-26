import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Inspiration", style: AppStyles.heading),
            const SizedBox(height: 20),
            const GlassContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.format_quote, color: AppColors.accentPurple, size: 30),
                  SizedBox(height: 10),
                  Text("Believe you can and you're halfway there.", style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(height: 10),
                  Text("— Theodore Roosevelt", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}