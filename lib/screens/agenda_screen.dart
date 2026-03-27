import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/constants.dart';
import '../core/quotes_data.dart';
import '../widgets/glass_container.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    QuotesData.loadPersistentData().then((_) => setState(() {}));
  }

  List<AppEvent> _getEventsForDay(DateTime day) {
    DateTime dateKey = DateTime(day.year, day.month, day.day);
    return QuotesData.events[dateKey] ?? [];
  }

  void _addEvent(AppEvent event) {
    DateTime dateKey = DateTime(event.date.year, event.date.month, event.date.day);
    setState(() {
      if (QuotesData.events[dateKey] != null) {
        QuotesData.events[dateKey]!.add(event);
      } else {
        QuotesData.events[dateKey] = [event];
      }
    });
    QuotesData.savePersistentData();
  }

  void _deleteEvent(AppEvent event) {
    DateTime dateKey = DateTime(event.date.year, event.date.month, event.date.day);
    setState(() {
      QuotesData.events[dateKey]?.remove(event);
    });
    QuotesData.savePersistentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/ispm_logo.png', fit: BoxFit.contain),
        ),
        title: const Text("Agenda Mpianatra", style: AppStyles.heading),
      ),
      body: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 15),
          Expanded(child: _buildEventList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentPurple,
        onPressed: () => _showAddEventSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        eventLoader: _getEventsForDay,
        calendarStyle: const CalendarStyle(
          markerDecoration: BoxDecoration(color: AppColors.accentPurple, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
          selectedDecoration: BoxDecoration(color: AppColors.accentPurple, shape: BoxShape.circle),
          defaultTextStyle: TextStyle(color: Colors.white),
          weekendTextStyle: TextStyle(color: Colors.redAccent),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay!);

    if (events.isEmpty) {
      return const Center(
        child: Text(
          "Tsy misy hetsika amin’ity andro ity.",
          style: TextStyle(color: Colors.white38),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(event.description,
                          style: const TextStyle(
                              color: Colors.white60, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text(
                        "Ora: ${event.time} | Fampahatsiahivana: ${event.reminder ? 'Mandeha' : 'Maty'}",
                        style: const TextStyle(
                            color: AppColors.accentPurple,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.redAccent),
                  onPressed: () => _deleteEvent(event),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAddEventSheet(BuildContext context) {
    String name = "";
    String desc = "";
    String time = "12:00";
    bool reminder = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161922),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              left: 20,
              right: 20,
              top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Hetsika vaovao", style: AppStyles.cardTitle),
              const SizedBox(height: 15),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Anaran'ny hetsika"),
                onChanged: (v) => name = v,
              ),

              const SizedBox(height: 10),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Fanazavana"),
                onChanged: (v) => desc = v,
              ),

              const SizedBox(height: 10),

              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Ora (oh: 14:00)"),
                onChanged: (v) => time = v,
              ),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Ampahatsiahivina",
                    style: TextStyle(color: Colors.white, fontSize: 14)),
                value: reminder,
                activeColor: AppColors.accentPurple,
                onChanged: (v) => setSheetState(() => reminder = v),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    if (name.isNotEmpty) {
                      _addEvent(AppEvent(
                        title: name,
                        description: desc,
                        date: _selectedDay!,
                        time: time,
                        reminder: reminder,
                      ));
                    }
                    Navigator.pop(context);
                  },
                  child: const Text("Hamorona hetsika",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
    );
  }
}