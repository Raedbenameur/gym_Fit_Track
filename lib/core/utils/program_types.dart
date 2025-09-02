import 'package:flutter/material.dart';

class ProgramTypes {
  List<Map<String, dynamic>> get programTypes => _programTypes;
  List<Map<String, dynamic>> get difficultyLevels => _difficultyLevels;
  List<Map<String, dynamic>> get periodOptions => _periodOptions;

  final _programTypes = [
    {
      'name': 'Muscle Gain',
      'icon': Icons.fitness_center,
      'color1': Color(0xFF3E7BFA),
      'color2': Color(0xFF6600CC),
    },
    {
      'name': 'Weight Loss',
      'icon': Icons.local_fire_department,
      'color1': Color(0xFFFF8800),
      'color2': Color(0xFFE63535),
    },
    {
      'name': 'Strength',
      'icon': Icons.trending_up,
      'color1': Color(0xFFFDDD48),
      'color2': Color(0xFF00B7C4),
    },
    {
      'name': 'Endurance',
      'icon': Icons.directions_run,
      'color1': Colors.purple,
      "color2": Color(0xFF6600CC),
    },
    {
      'name': 'Flexibility',
      'icon': Icons.self_improvement,
      'color1': Color.fromARGB(255, 255, 59, 219),
      'color2': Color(0xFF6600CC),
    },
    {'name': 'General Fitness', 'icon': Icons.favorite, 'color1': Colors.red},
  ];

  final List<Map<String, dynamic>> _difficultyLevels = [
    {'name': 'Beginner', 'color': const Color(0xFF05A660)},
    {'name': 'Intermediate', 'color': Color(0xFFFF8800)},
    {'name': 'Advanced', 'color': Color(0xFFE63535)},
    {'name': 'Expert', 'color': Color(0xFFB00020)},
  ];

  final List<Map<String, dynamic>> _periodOptions = [
    {
      'name': '4 Weeks',
      'value': '4',
      'icon': Icons.calendar_today,
      'description': 'Short term focus',
    },
    {
      'name': '8 Weeks',
      'value': '8',
      'icon': Icons.calendar_month,
      'description': 'Standard program',
    },
    {
      'name': '12 Weeks',
      'value': '12',
      'icon': Icons.date_range,
      'description': 'Extended training',
    },
    {
      'name': '16 Weeks',
      'value': '16',
      'icon': Icons.event_note,
      'description': 'Long term goals',
    },
    {
      'name': '24 Weeks',
      'value': '24',
      'icon': Icons.event_note,
      'description': 'Transformation plan',
    },
    {
      'name': 'Custom',
      'value': 'custom',
      'icon': Icons.edit_calendar,
      'description': 'Set your own duration',
    },
  ];
}
