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

    final dl = DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      _time!.hour,
      _time!.minute,
    );

    setState(() {
      TaskStorage.tasks.add(TodoTask(
        id: DateTime.now().toIso8601String(),
        title: _name.text,
        group: _group.text.isEmpty ? "Ankapobeny" : _group.text,
        deadline: dl,
        createdAt: DateTime.now(),
      ));
      TaskStorage.saveToPhone();
    });

    _name.clear();
    _group.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/ispm_logo.png',
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.school,
                    color: isDark ? Colors.white : Colors.black),
          ),
        ),
        title: Text(
          "Asa fianarana",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: TaskStorage.tasks.length,
        itemBuilder: (ctx, i) {
          final t = TaskStorage.tasks[i];
          bool isFirstInGroup =
              i == 0 || TaskStorage.tasks[i - 1].group != t.group;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isFirstInGroup)
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15, bottom: 8, left: 5),
                  child: Text(
                    t.group.toUpperCase(),
                    style: TextStyle(
                      color: t.groupColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 1.5,
                    ),
                  ),
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
                            activeColor: t.groupColor,
                            onChanged: (v) {
                              setState(() {
                                t.isCompleted = v!;
                                TaskStorage.saveToPhone();
                              });
                            },
                          ),

                          Expanded(
                            child: Text(
                              t.title,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface,
                                decoration: t.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                TaskStorage.tasks.removeAt(i);
                                TaskStorage.saveToPhone();
                              });
                            },
                          )
                        ],
                      ),

                      const SizedBox(height: 8),

                      LinearProgressIndicator(
                        value: t.timeLeftProgress,
                        backgroundColor:
                            isDark ? Colors.white10 : Colors.black12,
                        color:
                            t.isCompleted ? Colors.grey : t.groupColor,
                        minHeight: 6,
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Fe-potoana: ${DateFormat('HH:mm, MMM d').format(t.deadline)}",
                          style: TextStyle(
                            color: isDark
                                ? Colors.white38
                                : Colors.black38,
                            fontSize: 10,
                          ),
                        ),
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
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Asa vaovao",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            TextField(
              controller: _name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface),
              decoration:
                  const InputDecoration(labelText: "Inona no hatao?"),
            ),

            TextField(
              controller: _group,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface),
              decoration: const InputDecoration(
                  labelText: "Sokajy (oh: Matematika, AI)"),
            ),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Mametraha fe-potoana",
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant),
              ),
              trailing: const Icon(Icons.calendar_today,
                  color: Colors.deepPurpleAccent),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2027),
                );
                if (d != null) {
                  final t = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now());
                  if (t != null) {
                    setState(() {
                      _date = d;
                      _time = t;
                    });
                  }
                }
              },
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: _addTask,
              child: const Text(
                "Tehirizo ny asa",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}