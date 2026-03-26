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
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.auto_awesome, color: AppColors.accentPurple),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoodSection(),
            const SizedBox(height: 30),

            _sectionHeader("Upcoming Events", onMore: () {}),
            _compactRow([
              _eventCard("Project Demo", "2:00 PM", "March 27", Colors.orange),
              _eventCard("Group Meeting", "4:30 PM", "March 28", Colors.blue),
            ]),

            const SizedBox(height: 25),

            _sectionHeader("Urgent Deadlines", onMore: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const TasksScreen())
              );
            }),
            _compactRow([
              _deadlineCard("UI Design", "3h left", "Mar 26, 18:00", 0.8),
              _deadlineCard("SQL Script", "2 days left", "Mar 28, 23:59", 0.4),
            ]),
            
            const SizedBox(height: 30),
            _sectionHeader("Weekly Activity", onMore: () {}),
            Row(
              children: [
                Expanded(child: _statCard("Most Done", "Coding", "12h", Icons.trending_up, Colors.greenAccent)),
                const SizedBox(width: 15),
                Expanded(child: _statCard("Least Done", "Reading", "45m", Icons.trending_down, Colors.redAccent)),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, {required VoidCallback onMore}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppStyles.cardTitle),
          GestureDetector(
            onTap: onMore,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accentPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text("See all", style: TextStyle(color: AppColors.accentPurple, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _compactRow(List<Widget> children) {
    return Row(children: children.map((widget) => Expanded(child: widget)).toList());
  }

  Widget _eventCard(String title, String time, String date, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 20, height: 3, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.white70)),
            Text(date, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _deadlineCard(String task, String timeLeft, String exactDate, double progress) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(task, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
            Text(timeLeft, style: const TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
            Text(exactDate, style: const TextStyle(color: Colors.white38, fontSize: 9)),
            const SizedBox(height: 6),
            LinearProgressIndicator(value: progress, color: AppColors.accentPurple, minHeight: 2),
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
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(activity, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text(val, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildMoodSection() {
    return GlassContainer(
      child: Column(
        children: [
          Text(currentEmoji, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 10),
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