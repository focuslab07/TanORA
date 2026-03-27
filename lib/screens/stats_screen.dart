import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

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
                Icon(Icons.school, color: isDark ? Colors.white : Colors.black),
          ),
        ),
        title: Text(
          "Statistika",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 200, child: BarChartSample()),
              const SizedBox(height: 40),

              _row(context, "Fandaharana", 0.9, Colors.blue),
              _row(context, "Famakiana", 0.7, Colors.green),
              _row(context, "Fitantanana", 0.5, Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, double val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: val,
            color: color,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white10
                : Colors.black12,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}

class BarChartSample extends StatelessWidget {
  const BarChartSample({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 10,
                color: Colors.deepPurpleAccent,
                width: 18,
              )
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 15,
                color: Colors.blueAccent,
                width: 18,
              )
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 8,
                color: Colors.greenAccent,
                width: 18,
              )
            ],
          ),
        ],
      ),
    );
  }
}