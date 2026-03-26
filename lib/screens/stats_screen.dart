import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/constants.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Statistics", style: AppStyles.heading),
              const SizedBox(height: 30),
              const SizedBox(height: 200, child: BarChartSample()),
              const SizedBox(height: 30),
              _row("Coding", 0.9, Colors.blue),
              _row("Reading", 0.7, Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, double val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: val, color: color, backgroundColor: Colors.white10),
        ],
      ),
    );
  }
}

class BarChartSample extends StatelessWidget {
  const BarChartSample({super.key});
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: [
        BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10, color: AppColors.accentPurple, width: 15)]),
        BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 15, color: AppColors.accentPurple, width: 15)]),
        BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 8, color: AppColors.accentPurple, width: 15)]),
      ],
    ));
  }
}