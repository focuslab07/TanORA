import 'package:flutter/material.dart';
import '../core/constants.dart';
import 'home_screen.dart';
import 'quotes_screen.dart';
import 'agenda_screen.dart';
import 'tasks_screen.dart';
import 'stats_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const QuotesScreen(),
    const AgendaScreen(),
    const TasksScreen(),
    const StatsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      // We wrap the BottomNavigationBar in a Container or Theme to style the background
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.05), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          type: BottomNavigationBarType.fixed,
          
          // --- MAKING THE COLOR DISTINCT ---
          // Using a slightly lighter grey/navy than the primaryBg (0xFF0D0F14)
          backgroundColor: const Color(0xFF161922), 
          
          selectedItemColor: AppColors.accentPurple,
          unselectedItemColor: Colors.white30,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_quote_rounded),
              label: 'Quotes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_rounded),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }
}