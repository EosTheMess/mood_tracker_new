import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  String? selectedMood;
  String? selectedLabel;
  Color? selectedColor;

  final List<Map<String, dynamic>> moods = [
    {"label": "Happy", "icon": "😊", "color": Colors.yellow},
    {"label": "Sad", "icon": "😢", "color": Colors.blue},
    {"label": "Angry", "icon": "😡", "color": Colors.red},
    {"label": "Calm", "icon": "😌", "color": Colors.green},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today's Mood")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text("Select your mood"),
              value: selectedLabel,
              items: moods.map((m) {
                return DropdownMenuItem<String>(
                  value: m["label"] as String,
                  child: Text("${m["icon"]} ${m["label"]}"),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedLabel = val;
                  final mood = moods.firstWhere((m) => m["label"] == val);
                  selectedMood = mood["icon"] as String;
                  selectedColor = mood["color"] as Color;
                });
              },
            ),
            if (selectedLabel != null)
              Card(
                color: selectedColor ?? Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Today you feel $selectedLabel $selectedMood",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
