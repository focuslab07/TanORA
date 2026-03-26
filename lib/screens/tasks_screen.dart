import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("All Tasks", style: AppStyles.cardTitle),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _taskListItem("UI/UX Design", "3h 20m left", "Mar 26, 18:00", 0.8, Colors.purpleAccent),
          _taskListItem("Database Script", "2 days left", "Mar 28, 23:59", 0.4, Colors.orangeAccent),
          _taskListItem("ISPM Report", "4 days left", "Mar 30, 08:00", 0.1, Colors.blueAccent),
          _taskListItem("Management Quiz", "Completed", "Mar 24, 10:00", 1.0, Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _taskListItem(String title, String time, String date, double prog, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GlassContainer(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(width: 4, height: 50, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(time, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(date, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(value: prog, color: color, backgroundColor: Colors.white10, minHeight: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}