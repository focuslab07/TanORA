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
              child: const Icon(Icons.auto_awesome, color: AppColors.accentPurple),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- MOOD SECTION (Same as before) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildMoodSection(),
            ),

            const SizedBox(height: 30),

            // --- SECTION 1: INCOMING EVENTS ---
            _sectionHeader("Upcoming Events"),
            _horizontalScrollRow([
              _eventCard("Project Demo", "2:00 PM", "Room 402", Colors.orange),
              _eventCard("Group Meeting", "4:30 PM", "Discord", Colors.blue),
              _eventCard("ISPM Exam", "Tomorrow", "Main Hall", Colors.red),
            ]),

            const SizedBox(height: 25),

            // --- SECTION 2: DEADLINE TASKS ---
            _sectionHeader("Urgent Deadlines"),
            _horizontalScrollRow([
              _deadlineCard("UI Design", "3h left", 0.8),
              _deadlineCard("SQL Script", "6h left", 0.4),
              _deadlineCard("PHP Auth", "9h left", 0.2),
            ]),

            const SizedBox(height: 25),

            // --- SECTION 3: WEEKLY STATS ---
            _sectionHeader("Weekly Activity"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: _statCard("Most Done", "Coding", "12h", Icons.trending_up, Colors.greenAccent)),
                  const SizedBox(width: 15),
                  Expanded(child: _statCard("Least Done", "Reading", "45m", Icons.trending_down, Colors.redAccent)),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- Helper UI Components ---

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title, style: AppStyles.cardTitle),
    );
  }

  Widget _horizontalScrollRow(List<Widget> children) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(children: children),
    );
  }

  Widget _eventCard(String title, String time, String loc, Color color) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      child: GlassContainer(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 5),
            Row(children: [const Icon(Icons.access_time, size: 12, color: Colors.grey), const SizedBox(width: 5), Text(time, style: AppStyles.subHeading)]),
            Row(children: [const Icon(Icons.place, size: 12, color: Colors.grey), const SizedBox(width: 5), Text(loc, style: AppStyles.subHeading)]),
          ],
        ),
      ),
    );
  }

  Widget _deadlineCard(String task, String timeLeft, double progress) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      child: GlassContainer(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 5),
            Text(timeLeft, style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: progress, backgroundColor: Colors.white10, color: AppColors.accentPurple),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String activity, String val, IconData icon, Color color) {
    return GlassContainer(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(activity, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(val, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMoodSection() {
    return GlassContainer(
      child: Column(
        children: [
          Text(currentEmoji, style: const TextStyle(fontSize: 35)),
          const SizedBox(height: 8),
          Text(currentQuote, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _moodBtn("😞", "Difficulties are just tests."),
              _moodBtn("😐", "Stay focused on the goal."),
              _moodBtn("😊", "You're doing great!"),
              _moodBtn("🤩", "Let's innovate today!"),
            ],
          )
        ],
      ),
    );
  }

  Widget _moodBtn(String emoji, String quote) {
    return GestureDetector(
      onTap: () => setState(() { currentEmoji = emoji; currentQuote = quote; }),
      child: Text(emoji, style: const TextStyle(fontSize: 22)),
    );
  }
}