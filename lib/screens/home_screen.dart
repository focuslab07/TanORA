import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';
import 'tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentQuote = "Take a deep breath. You're doing great.";
  String currentEmoji = "🌿";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("TanOra", style: AppStyles.heading(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoodSection(context),
            const SizedBox(height: 35),

            _sectionHeader(context, "Upcoming Events", onMore: () {}),
            _compactRow([
              _eventCard(context, "Project Demo", "2:00 PM", "March 27", AppColors.softOrange),
              _eventCard(context, "Group Meeting", "4:30 PM", "March 28", Colors.blueAccent),
            ]),

            const SizedBox(height: 30),

            _sectionHeader(context, "Urgent Deadlines", onMore: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TasksScreen()));
            }),
            _compactRow([
              _deadlineCard(context, "UI Design", "3h left", "18:00 Today", 0.8),
              _deadlineCard(context, "SQL Script", "2 days left", "Mar 28", 0.4),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _sectionHeader(BuildContext context, String title, {required VoidCallback onMore}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.cardTitle(context)),
          GestureDetector(
            onTap: onMore,
            child: const Text("See all", style: TextStyle(color: AppColors.accentPurple, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _compactRow(List<Widget> children) {
    return Row(children: children.map((widget) => Expanded(child: widget)).toList());
  }

  Widget _eventCard(BuildContext context, String title, String time, String date, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 4, backgroundColor: color),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text("$date • $time", style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _deadlineCard(BuildContext context, String task, String timeLeft, String exact, double progress) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(timeLeft, style: const TextStyle(color: AppColors.softRed, fontSize: 11, fontWeight: FontWeight.bold)),
            Text(exact, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            const SizedBox(height: 12),
            LinearProgressIndicator(value: progress, color: AppColors.accentPurple, minHeight: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSection(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(currentEmoji, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 12),
          Text(currentQuote, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}