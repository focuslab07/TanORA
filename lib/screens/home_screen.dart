import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentQuote = "How are you feeling today?";
  String currentEmoji = "✨";

  void updateMood(String emoji, String quote) {
    setState(() {
      currentEmoji = emoji;
      currentQuote = quote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("TanOra", style: AppStyles.heading),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: AppColors.accentPurple.withOpacity(0.2),
              child: const Icon(Icons.auto_awesome, color: AppColors.accentPurple), // Placeholder for your Logo
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Thursday, March 26", style: AppStyles.subHeading),
            const SizedBox(height: 20),

            // --- MOOD & DYNAMIC QUOTE SECTION ---
            GlassContainer(
              child: Column(
                children: [
                  Text(currentEmoji, style: const TextStyle(fontSize: 40)),
                  const SizedBox(height: 10),
                  Text(
                    currentQuote,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _moodButton("😞", "Tough times don't last, tough people do."),
                      _moodButton("😐", "One day at a time. You're doing fine."),
                      _moodButton("😊", "Keep that energy! Your smile is a superpower."),
                      _moodButton("🤩", "You are unstoppable today. Let's crush it!"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text("Dashboard Summary", style: AppStyles.cardTitle),
            const SizedBox(height: 15),

            // --- SUMMARY GRID ---
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1.1,
              children: [
                _summaryCard(Icons.event, "Next Event", "Project Demo", "2:00 PM", Colors.orange),
                _summaryCard(Icons.priority_high, "Deadline", "UI Design", "In 3h", Colors.redAccent),
                _summaryCard(Icons.trending_up, "Most Done", "Coding", "5.2h", Colors.greenAccent),
                _summaryCard(Icons.trending_down, "Least Done", "Reading", "15m", Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _moodButton(String emoji, String quote) {
    return GestureDetector(
      onTap: () => updateMood(emoji, quote),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
        ),
        child: Text(emoji, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _summaryCard(IconData icon, String title, String value, String sub, Color color) {
    return GlassContainer(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(sub, style: TextStyle(fontSize: 10, color: color.withOpacity(0.8))),
            ],
          ),
        ],
      ),
    );
  }
}