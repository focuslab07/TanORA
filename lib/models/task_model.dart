import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoTask {
  final String id, title, group;
  final DateTime deadline, createdAt;
  bool isCompleted;

  TodoTask({
    required this.id, required this.title, required this.group, 
    required this.deadline, required this.createdAt, this.isCompleted = false,
  });

  // Shrinking Bar Logic (1.0 to 0.0)
  double get timeLeftProgress {
    if (isCompleted) return 0.0;
    final now = DateTime.now();
    if (now.isAfter(deadline)) return 0.0;
    final total = deadline.difference(createdAt).inSeconds;
    final remaining = deadline.difference(now).inSeconds;
    return total <= 0 ? 0.0 : (remaining / total).clamp(0.0, 1.0);
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'group': group, 
    'deadline': deadline.toIso8601String(), 
    'createdAt': createdAt.toIso8601String(),
    'isCompleted': isCompleted,
  };

  factory TodoTask.fromJson(Map<String, dynamic> json) => TodoTask(
    id: json['id'], title: json['title'], group: json['group'],
    deadline: DateTime.parse(json['deadline']),
    createdAt: DateTime.parse(json['createdAt']),
    isCompleted: json['isCompleted'] ?? false,
  );
}

class TaskStorage {
  static List<TodoTask> tasks = [];

  // NEW: Sorts tasks alphabetically by Group
  static void sortTasks() {
    tasks.sort((a, b) => a.group.toLowerCase().compareTo(b.group.toLowerCase()));
  }

  static Future<void> saveToPhone() async {
    sortTasks(); // Sort before saving
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks_persistence', jsonEncode(tasks.map((t) => t.toJson()).toList()));
  }

  static Future<void> loadFromPhone() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('tasks_persistence');
    if (data != null) {
      Iterable decoded = jsonDecode(data);
      tasks = List<TodoTask>.from(decoded.map((m) => TodoTask.fromJson(m)));
      sortTasks(); // Sort after loading
    }
  }
}