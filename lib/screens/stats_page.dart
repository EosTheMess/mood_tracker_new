import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/storage_service.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Map<String, dynamic> _entries = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final all = await StorageService.getAllEntries();
    setState(() => _entries = all);
  }

  int _moodValue(String mood) {
    switch (mood) {
      case '😊': return 5;
      case '🤩': return 5;
      case '😎': return 4;
      case '😐': return 3;
      case '😴': return 2;
      case '😢': return 1;
      case '🤒': return 1;
      case '😡': return 0;
      default: return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final start = now.subtract(const Duration(days: 29));

    final spots = List.generate(30, (i) {
      final day = DateTime(start.year, start.month, start.day + i);
      final key = DateFormat('yyyy-MM-dd').format(day);
      final mood = _entries[key]?['mood'] as String?;
      return FlSpot(i.toDouble(), (mood != null ? _moodValue(mood) : 0).toDouble());
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mood Trend - Last 30 Days', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: LineChart(LineChartData(
              lineBarsData: [
                LineChartBarData(spots: spots, isCurved: true, color: Colors.teal, barWidth: 3, dotData: FlDotData(show: true))
              ],
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(show: true, bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))),
              minY: 0,
              maxY: 5,
            )),
          ),
        ],
      ),
    );
  }
}
