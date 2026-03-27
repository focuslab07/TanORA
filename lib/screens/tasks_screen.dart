import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import '../widgets/glass_container.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final _name = TextEditingController();
  final _group = TextEditingController();
  DateTime? _date;
  TimeOfDay? _time;

  void _addTask() {
    if (_name.text.isEmpty || _date == null || _time == null) return;
    final dl = DateTime(_date!.year, _date!.month, _date!.day, _time!.hour, _time!.minute);
    
    setState(() {
      TaskStorage.tasks.add(TodoTask(
        id: DateTime.now().toIso8601String(),
        title: _name.text,
        group: _group.text.isEmpty ? "General" : _group.text,
        deadline: dl,
        createdAt: DateTime.now(),
      ));
      TaskStorage.saveToPhone(); // This now auto-sorts by group
    });
    
    _name.clear(); _group.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Study Tasks"), backgroundColor: Colors.transparent),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: TaskStorage.tasks.length,
        itemBuilder: (ctx, i) {
          final t = TaskStorage.tasks[i];
          
          // Logic to show a small group label if this is the first task of a new group
          bool isFirstInGroup = i == 0 || TaskStorage.tasks[i-1].group != t.group;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstInGroup)
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8, left: 5),
                  child: Text(t.group.toUpperCase(), 
                    style: const TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassContainer(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: t.isCompleted, 
                            activeColor: Colors.deepPurpleAccent,
                            onChanged: (v) {
                              setState(() { t.isCompleted = v!; TaskStorage.saveToPhone(); });
                            }
                          ),
                          Expanded(child: Text(t.title, style: TextStyle(color: Colors.white, decoration: t.isCompleted ? TextDecoration.lineThrough : null))),
                          IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20), onPressed: () {
                            setState(() { TaskStorage.tasks.removeAt(i); TaskStorage.saveToPhone(); });
                          })
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: t.timeLeftProgress,
                        backgroundColor: Colors.white10,
                        color: t.timeLeftProgress < 0.2 ? Colors.orangeAccent : Colors.deepPurpleAccent,
                        minHeight: 6,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight, 
                        child: Text("Due: ${DateFormat('HH:mm, MMM d').format(t.deadline)}", style: const TextStyle(color: Colors.white38, fontSize: 10))
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () => _showModal(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161922),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("New Task", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(controller: _name, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "What needs to be done?")),
            TextField(controller: _group, style: const TextStyle(color: Colors.white), decoration: const InputDecoration(labelText: "Group (e.g. Math, AI)")),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Set Deadline", style: TextStyle(color: Colors.white70)),
              trailing: const Icon(Icons.calendar_today, color: Colors.deepPurpleAccent),
              onTap: () async {
                final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2027));
                if (d != null) {
                  final t = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (t != null) setState(() { _date = d; _time = t; });
                }
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, minimumSize: const Size(double.infinity, 45)),
              onPressed: _addTask, 
              child: const Text("Save Task")
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}