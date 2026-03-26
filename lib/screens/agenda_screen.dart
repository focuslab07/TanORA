import 'package:flutter/material.dart';
import '../core/constants.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Agenda", style: AppStyles.heading),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tasks for March 26 listed here...", 
              style: AppStyles.subHeading,
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.glassWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(child: Text("Calendar Placeholder", style: TextStyle(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}