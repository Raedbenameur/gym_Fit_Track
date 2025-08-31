import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/widgets/app_bar.dart' as custom_app_bar;
import 'package:gym/widgets/costum_button.dart';
import 'package:gym/widgets/programs/custom_field.dart';
import 'package:smooth_list_view/smooth_list_view.dart';
import 'program_day_exercises.dart';
import '/routes.dart' as custom_route;

class ProgramDaysScreen extends StatefulWidget {
  final Map<String, dynamic>? programData;

  const ProgramDaysScreen({super.key, this.programData});

  @override
  State<ProgramDaysScreen> createState() => _ProgramDaysScreenState();
}

class _ProgramDaysScreenState extends State<ProgramDaysScreen> {
  int _selectedDays = 3;
  final Map<String, Map<String, dynamic>> _weekSchedule = {};

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _workoutTypes = [
    'Chest & Triceps',
    'Back & Biceps',
    'Legs & Glutes',
    'Shoulders & Abs',
    'Arms',
    'Full Body',
    'Cardio',
    'Rest Day',
    'Custom Workout',
  ];

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
  }

  void _initializeSchedule() {
    for (String day in _daysOfWeek) {
      _weekSchedule[day] = {
        'isActive': false,
        'workoutType': 'Rest Day',
        'customWorkout': '',
        'isCustom': false,
        'exercises': <Map<String, dynamic>>[], // Add exercises list
      };
    }
  }

  void _updateDaysCount(int days) {
    setState(() {
      _selectedDays = days;
      // Reset all days to inactive first
      for (String day in _daysOfWeek) {
        _weekSchedule[day]!['isActive'] = false;
        _weekSchedule[day]!['workoutType'] = 'Rest Day';
      }
      // Activate the first N days
      for (int i = 0; i < days && i < _daysOfWeek.length; i++) {
        _weekSchedule[_daysOfWeek[i]]!['isActive'] = true;
        _weekSchedule[_daysOfWeek[i]]!['workoutType'] = 'Full Body';
      }
    });
  }

  void _toggleDayActive(String day) {
    setState(() {
      final currentActive = _weekSchedule[day]!['isActive'] as bool;
      _weekSchedule[day]!['isActive'] = !currentActive;

      if (!currentActive) {
        _weekSchedule[day]!['workoutType'] = 'Full Body';
      } else {
        _weekSchedule[day]!['workoutType'] = 'Rest Day';
      }
    });
  }

  void _updateWorkoutType(String day, String workoutType) {
    setState(() {
      _weekSchedule[day]!['workoutType'] = workoutType;
      _weekSchedule[day]!['isCustom'] = workoutType == 'Custom Workout';
      if (workoutType != 'Custom Workout') {
        _weekSchedule[day]!['customWorkout'] = '';
      }
    });
  }

  void _saveSchedule() {
    final activeWorkouts = _weekSchedule.entries
        .where((entry) => entry.value['isActive'] == true)
        .map(
          (entry) => {
            'day': entry.key,
            'workoutType': entry.value['workoutType'],
            'customWorkout': entry.value['customWorkout'],
            'exercises': entry.value['exercises'],
          },
        )
        .toList();

    if (activeWorkouts.isEmpty) {
      _showErrorSnackBar('Please select at least one workout day');
      return;
    }

    final programSchedule = {
      'totalDays': _selectedDays,
      'schedule': _weekSchedule,
      'activeWorkouts': activeWorkouts,
    };

    // Show success and navigate back with data
    _showSuccessSnackBar('Schedule created successfully!');
    Navigator.pop(context, programSchedule);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              custom_app_bar.AppBar(
                title: 'Program Schedule',
                subtitle: 'Set your weekly workout plan',
              ),
              const SizedBox(height: 32),

              // Training Days Selector
              Text(
                'Training Days per Week',
                style: Fonts.text.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(7, (index) {
                  final days = index + 1;
                  final isSelected = _selectedDays == days;

                  return GestureDetector(
                    onTap: () => _updateDaysCount(days),
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[700]!,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$days',
                          style: Fonts.title.copyWith(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Weekly Schedule
              Text(
                'Weekly Schedule',
                style: Fonts.text.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Days List
              Expanded(
                child: SmoothListView.builder(
                  duration: const Duration(milliseconds: 200),
                  itemCount: _daysOfWeek.length,
                  itemBuilder: (context, index) {
                    final day = _daysOfWeek[index];
                    final dayData = _weekSchedule[day]!;
                    final isActive = dayData['isActive'] as bool;
                    final workoutType = dayData['workoutType'] as String;
                    final isCustom = dayData['isCustom'] as bool;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF2A2A2A)
                            : const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isActive
                              ? const Color.fromARGB(
                                  197,
                                  30,
                                  255,
                                  146,
                                ).withOpacity(0.2)
                              : Colors.grey[800]!,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Day Header
                          Row(
                            children: [
                              // Toggle Switch
                              GestureDetector(
                                onTap: () => _toggleDayActive(day),
                                child: Container(
                                  width: 45,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? const Color.fromARGB(
                                            197,
                                            30,
                                            255,
                                            146,
                                          )
                                        : Colors.grey[700],
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 200),
                                    alignment: isActive
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Day Name
                              Expanded(
                                child: Text(
                                  day,
                                  style: Fonts.subtitle.copyWith(
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey[500],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              // Workout Type Indicator
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color.fromARGB(
                                          197,
                                          30,
                                          255,
                                          146,
                                        ).withOpacity(0.2)
                                      : Colors.grey[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  workoutType,
                                  style: Fonts.text.copyWith(
                                    color: isActive
                                        ? const Color.fromARGB(
                                            197,
                                            30,
                                            255,
                                            146,
                                          )
                                        : Colors.grey[500],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Workout Type Dropdown (if active)
                          if (isActive) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3A3A3A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: workoutType,
                                  isExpanded: true,
                                  dropdownColor: const Color(0xFF3A3A3A),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey[400],
                                  ),
                                  style: Fonts.text.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  items: _workoutTypes.map((String type) {
                                    return DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      _updateWorkoutType(day, newValue);
                                    }
                                  },
                                ),
                              ),
                            ),

                            // Custom Workout Input (if custom selected)
                            if (isCustom) ...[
                              const SizedBox(height: 12),
                              CustomField(
                                controller: TextEditingController(),
                                labelText: '',
                                onChanged: (value) {
                                  _weekSchedule[day]!['customWorkout'] = value;
                                },
                                hintText: "Enter custom workout",
                              ),
                            ],

                            // Add exercises button (if active and not rest day)
                            if (workoutType != 'Rest Day') ...[
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  // Navigate to exercises screen with slide up animation
                                  custom_route
                                      .fadeToPage(
                                        context,
                                        ProgramDayExercisesScreen(
                                          day: day,
                                          workoutType: workoutType,
                                          exercises:
                                              _weekSchedule[day]!['exercises'] ??
                                              [],
                                        ),
                                      )
                                      .then((exercises) {
                                        if (exercises != null) {
                                          setState(() {
                                            _weekSchedule[day]!['exercises'] =
                                                exercises;
                                          });
                                        }
                                      });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3A3A3A),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                        197,
                                        30,
                                        255,
                                        146,
                                      ).withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        color: const Color.fromARGB(
                                          197,
                                          30,
                                          255,
                                          146,
                                        ),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Add Exercises',
                                              style: Fonts.text.copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              (_weekSchedule[day]!['exercises']
                                                              as List?)
                                                          ?.isEmpty ??
                                                      true
                                                  ? 'No exercises added'
                                                  : '${(_weekSchedule[day]!['exercises'] as List).length} exercises',
                                              style: Fonts.text.copyWith(
                                                color: Colors.grey[400],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            197,
                                            30,
                                            255,
                                            146,
                                          ).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: const Color.fromARGB(
                                            197,
                                            30,
                                            255,
                                            146,
                                          ),
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Save Button
              const SizedBox(height: 10),
              CustomButton(
                fontSize: 14,
                height: 12,
                text: 'Save Schedule',
                color: AppColors.primaryColor,
                textColor: Colors.black,
                onPressed: () {
                  _saveSchedule();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
