import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

class TimeSelector extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final Function(String)? onTimeSelected;
  final String? initialTime;
  final bool show24Hour;

  const TimeSelector({
    super.key,
    this.title = 'Workout Time',
    this.subtitle = 'Select your preferred workout time:',
    this.onTimeSelected,
    this.initialTime,
    this.show24Hour = false,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String? _selectedTime;

  // Predefined time options with weather images
  final List<Map<String, dynamic>> _timeOptions = [
    {'time': '6:00 AM', 'image': 'assets/images/weather/sunrise.png'},
    {'time': '7:00 AM', 'image': 'assets/images/weather/sunrise.png'},
    {'time': '8:00 AM', 'image': 'assets/images/weather/sun.png'},
    {'time': '9:00 AM', 'image': 'assets/images/weather/sun.png'},
    {'time': '10:00 AM', 'image': 'assets/images/weather/sun.png'},
    {'time': '11:00 AM', 'image': 'assets/images/weather/sun.png'},
    {'time': '12:00 PM', 'image': 'assets/images/weather/sun.png'},
    {'time': '1:00 PM', 'image': 'assets/images/weather/sun.png'},
    {'time': '2:00 PM', 'image': 'assets/images/weather/sun.png'},
    {'time': '3:00 PM', 'image': 'assets/images/weather/sun.png'},
    {'time': '4:00 PM', 'image': 'assets/images/weather/sun.png'},
    {'time': '5:00 PM', 'image': 'assets/images/weather/sunset.png'},
    {'time': '6:00 PM', 'image': 'assets/images/weather/sunset.png'},
    {'time': '7:00 PM', 'image': 'assets/images/weather/sunset.png'},
    {'time': '8:00 PM', 'image': 'assets/images/weather/moon.png'},
    {'time': '9:00 PM', 'image': 'assets/images/weather/moon.png'},
    {'time': '10:00 PM', 'image': 'assets/images/weather/moon.png'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  void _showTimePickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1D1D1D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Select Workout Time',
              style: Fonts.title.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Time options grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemCount: _timeOptions.length,
                itemBuilder: (context, index) {
                  final timeOption = _timeOptions[index];
                  final isSelected = _selectedTime == timeOption['time'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = timeOption['time'];
                      });
                      if (widget.onTimeSelected != null) {
                        widget.onTimeSelected!(timeOption['time']);
                      }
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromARGB(
                                255,
                                254,
                                229,
                                88,
                              ).withValues(alpha: 0.2)
                            : const Color(0xFF2A2A2A),
                        borderRadius: isSelected
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey[700]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Weather image instead of icon
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  timeOption['time'],
                                  style: Fonts.text.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(child: Image.asset(timeOption['image'])),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Custom time button
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: AppColors.primaryColor,
                          onPrimary: Colors.black,
                          surface: const Color(0xFF1D1D1D),
                          onSurface: Colors.white,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (picked != null) {
                  final formattedTime = _formatTime(picked);
                  setState(() {
                    _selectedTime = formattedTime;
                  });
                  if (widget.onTimeSelected != null) {
                    widget.onTimeSelected!(formattedTime);
                  }
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[700]!, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      'Custom Time',
                      style: Fonts.subtitle.copyWith(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Get appropriate weather image for selected time display
  String _getWeatherImageForTime(String time) {
    final option = _timeOptions.firstWhere(
      (option) => option['time'] == time,
      orElse: () => {'image': 'assets/images/weather/sun.png'},
    );
    return option['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Fonts.text.copyWith(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
        ],

        if (widget.subtitle != null) ...[
          Text(
            widget.subtitle!,
            style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 12),
          ),
          const SizedBox(height: 12),
        ],

        GestureDetector(
          onTap: _showTimePickerDialog,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 38, 38, 38),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[700]!, width: 1),
            ),
            child: Row(
              children: [
                // Clock icon on the left when no time is selected
                if (_selectedTime == null)
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                  ),

                // Time text
                Expanded(
                  child: Text(
                    _selectedTime ?? 'Select workout time',
                    style: Fonts.title.copyWith(
                      color: _selectedTime != null
                          ? Colors.white
                          : Colors.grey[400],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Weather image on the right when time is selected
                if (_selectedTime != null)
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(left: 12),
                    child: Image.asset(
                      _getWeatherImageForTime(_selectedTime!),
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.access_time,
                          color: Colors.grey[400],
                          size: 20,
                        );
                      },
                    ),
                  )
                else
                  // Dropdown arrow when no time is selected
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[400],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
