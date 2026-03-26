import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/glass_container.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text("Tasks", style: AppStyles.heading),
            const SizedBox(height: 20),
            _taskItem("Java app", "Group A", "Done at 14:32", true),
            _taskItem("Read book", "Group B", "Due 20:00 today", false),
            _taskItem("Morning run", "Group C", "Due 07:00 tomorrow", false),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentPurple,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text("New Task", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _taskItem(String title, String group, String time, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, 
                color: isDone ? AppColors.accentPurple : Colors.grey),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyles.cardTitle),
                Text("$group · $time", style: AppStyles.subHeading),
              ],
            )
          ],
        ),
      ),
    );
  }
}