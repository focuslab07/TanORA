import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../core/constants.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: DateTime(2026, 3, 26),
              firstDay: DateTime(2026, 1, 1),
              lastDay: DateTime(2026, 12, 31),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(color: AppColors.accentPurple, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            ),
            const Expanded(
              child: Center(child: Text("Tasks for March 26 listed here...", style: AppStyles.subHeading)),
            )
          ],
        ),
      ),
    );
  }
}