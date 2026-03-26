import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Good morning, Alex 👋", style: AppStyles.heading),
              const Text("Thursday · March 26 · 7 day streak", style: AppStyles.subHeading),
              const SizedBox(height: 30),
              const GlassContainer(
                child: Column(
                  children: [
                    Text("HOW DO YOU FEEL TODAY?", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text("😞", style: TextStyle(fontSize: 24)), Text("😐", style: TextStyle(fontSize: 24)), Text("😊", style: TextStyle(fontSize: 24)), Text("🤩", style: TextStyle(fontSize: 24))],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _statBox("4/6", "tasks today")),
                  const SizedBox(width: 15),
                  Expanded(child: _statBox("81%", "weekly rate")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String val, String label) {
    return GlassContainer(
      child: Column(
        children: [
          Text(val, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: AppStyles.subHeading),
        ],
      ),
    );
  }
}