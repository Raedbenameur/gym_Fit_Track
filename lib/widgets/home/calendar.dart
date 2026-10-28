import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';

class WorkoutCalendar extends StatefulWidget {
  const WorkoutCalendar({super.key});

  @override
  State<WorkoutCalendar> createState() => _WorkoutCalendarState();
}

class _WorkoutCalendarState extends State<WorkoutCalendar> {
  DateTime selectedDate = DateTime.now();

  // Completed workout dates - marked as done with green
  Set<DateTime> completedWorkouts = {
    DateTime(2025, 8, 1),
    DateTime(2025, 8, 2),
    DateTime(2025, 8, 3),
    DateTime(2025, 8, 5),
    DateTime(2025, 8, 8),
    DateTime(2025, 8, 10),
    DateTime(2025, 8, 15),
    DateTime(2025, 8, 17),
    DateTime(2025, 8, 22),
    DateTime(2025, 8, 25),
  };

  // Missed workout dates - marked as missed with red
  Set<DateTime> missedWorkouts = {
    DateTime(2025, 8, 4),
    DateTime(2025, 8, 7),
    DateTime(2025, 8, 12),
    DateTime(2025, 8, 18),
    DateTime(2025, 8, 24),
    DateTime(2025, 8, 27),
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month - 1,
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                Text(
                  _getMonthYear(selectedDate),
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month + 1,
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Weekday headers
            Row(
              children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: Fonts.text.copyWith(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),

            // Calendar grid
            ..._buildCalendarGrid(),

            const SizedBox(height: 16),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(Icons.check_circle, Colors.green, 'Completed'),
                _buildLegendItem(Icons.cancel, Colors.red, 'Missed'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(IconData icon, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }

  List<Widget> _buildCalendarGrid() {
    List<Widget> rows = [];
    DateTime firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      1,
    );
    DateTime lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );

    // Get first day of week (Monday = 1, Sunday = 7)
    int firstWeekday = firstDayOfMonth.weekday;

    // Calculate total days to show
    int totalDays = lastDayOfMonth.day;
    int startingEmptyDays = firstWeekday - 1;

    List<Widget> dayWidgets = [];

    // Add empty days for previous month
    for (int i = 0; i < startingEmptyDays; i++) {
      dayWidgets.add(const SizedBox(height: 40));
    }

    // Add days of current month
    for (int day = 1; day <= totalDays; day++) {
      DateTime currentDay = DateTime(
        selectedDate.year,
        selectedDate.month,
        day,
      );
      bool isCompleted = _isWorkoutCompleted(currentDay);
      bool isMissed = _isWorkoutMissed(currentDay);
      bool isToday = _isToday(currentDay);

      dayWidgets.add(_buildDayWidget(day, isCompleted, isMissed, isToday));
    }

    // Group days into weeks (rows of 7)
    for (int i = 0; i < dayWidgets.length; i += 7) {
      List<Widget> week = dayWidgets.sublist(
        i,
        (i + 7 < dayWidgets.length) ? i + 7 : dayWidgets.length,
      );

      // Fill remaining days if needed
      while (week.length < 7) {
        week.add(const SizedBox(height: 40));
      }

      rows.add(Row(children: week.map((day) => Expanded(child: day)).toList()));

      if (i + 7 < dayWidgets.length) {
        rows.add(const SizedBox(height: 4));
      }
    }

    return rows;
  }

  Widget _buildDayWidget(
    int day,
    bool isCompleted,
    bool isMissed,
    bool isToday,
  ) {
    Color backgroundColor = Colors.transparent;
    Color borderColor = Colors.transparent;
    Color textColor = Colors.grey[400]!;

    if (isToday) {
      borderColor = AppColors.primaryColor;
      textColor = AppColors.primaryColor;
    } else if (isCompleted) {
      backgroundColor = Colors.green.withValues(alpha: 0.2);
      textColor = Colors.white;
    } else if (isMissed) {
      backgroundColor = Colors.red.withValues(alpha: 0.2);
      textColor = Colors.white;
    }

    return Container(
      height: 40,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: isToday ? Border.all(color: borderColor, width: 2) : null,
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              day.toString(),
              style: Fonts.text.copyWith(
                color: textColor,
                fontSize: 16,
                fontWeight: isToday || isCompleted || isMissed
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          // Status icon
          if (isCompleted)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
            ),
          if (isMissed)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 12),
              ),
            ),
        ],
      ),
    );
  }

  bool _isWorkoutCompleted(DateTime date) {
    return completedWorkouts.any(
      (workoutDate) =>
          workoutDate.year == date.year &&
          workoutDate.month == date.month &&
          workoutDate.day == date.day,
    );
  }

  bool _isWorkoutMissed(DateTime date) {
    return missedWorkouts.any(
      (workoutDate) =>
          workoutDate.year == date.year &&
          workoutDate.month == date.month &&
          workoutDate.day == date.day,
    );
  }

  bool _isToday(DateTime date) {
    DateTime today = DateTime.now();
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }

  String _getMonthYear(DateTime date) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
