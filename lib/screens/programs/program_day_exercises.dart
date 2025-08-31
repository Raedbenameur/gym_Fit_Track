import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/widgets/costum_button.dart';
import 'package:gym/widgets/search_field.dart';

class ProgramDayExercisesScreen extends StatefulWidget {
  final String day;
  final String workoutType;
  final List<Map<String, dynamic>> exercises;

  const ProgramDayExercisesScreen({
    super.key,
    required this.day,
    required this.workoutType,
    required this.exercises,
  });

  @override
  State<ProgramDayExercisesScreen> createState() => _ProgramDayExercisesState();
}

class _ProgramDayExercisesState extends State<ProgramDayExercisesScreen> {
  late List<Map<String, dynamic>> _exercises;
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _searchQuery = '';

  final List<String> _filterOptions = [
    'All',
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Arms',
    'Core',
  ];

  // Sample exercise database
  final List<Map<String, dynamic>> _availableExercises = [
    {
      'name': 'Bench Press',
      'muscle': 'Chest',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Incline Dumbbell Press',
      'muscle': 'Chest',
      'type': 'Strength',
      'equipment': 'Dumbbell',
    },
    {
      'name': 'Push Ups',
      'muscle': 'Chest',
      'type': 'Bodyweight',
      'equipment': 'None',
    },
    {
      'name': 'Chest Flyes',
      'muscle': 'Chest',
      'type': 'Strength',
      'equipment': 'Dumbbell',
    },
    {
      'name': 'Pull Ups',
      'muscle': 'Back',
      'type': 'Bodyweight',
      'equipment': 'Pull-up Bar',
    },
    {
      'name': 'Barbell Rows',
      'muscle': 'Back',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Lat Pulldown',
      'muscle': 'Back',
      'type': 'Machine',
      'equipment': 'Cable Machine',
    },
    {
      'name': 'Deadlift',
      'muscle': 'Back',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Squats',
      'muscle': 'Legs',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Leg Press',
      'muscle': 'Legs',
      'type': 'Machine',
      'equipment': 'Leg Press Machine',
    },
    {
      'name': 'Lunges',
      'muscle': 'Legs',
      'type': 'Bodyweight',
      'equipment': 'None',
    },
    {
      'name': 'Romanian Deadlift',
      'muscle': 'Legs',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Overhead Press',
      'muscle': 'Shoulders',
      'type': 'Strength',
      'equipment': 'Barbell',
    },
    {
      'name': 'Lateral Raises',
      'muscle': 'Shoulders',
      'type': 'Strength',
      'equipment': 'Dumbbell',
    },
    {
      'name': 'Bicep Curls',
      'muscle': 'Arms',
      'type': 'Strength',
      'equipment': 'Dumbbell',
    },
    {
      'name': 'Tricep Dips',
      'muscle': 'Arms',
      'type': 'Bodyweight',
      'equipment': 'Bench',
    },
    {
      'name': 'Plank',
      'muscle': 'Core',
      'type': 'Bodyweight',
      'equipment': 'None',
    },
    {
      'name': 'Russian Twists',
      'muscle': 'Core',
      'type': 'Bodyweight',
      'equipment': 'None',
    },
  ];

  List<Map<String, dynamic>> _filteredExercises = [];

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.exercises);
    _filterExercises();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterExercises() {
    setState(() {
      _filteredExercises = _availableExercises.where((exercise) {
        bool matchesSearch = exercise['name'].toString().toLowerCase().contains(
          _searchQuery.toLowerCase(),
        );

        bool matchesFilter =
            _selectedFilter == 'All' ||
            exercise['muscle'].toString().toLowerCase().contains(
              _selectedFilter.toLowerCase(),
            );

        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _addExercise(Map<String, dynamic> exercise) {
    setState(() {
      _exercises.add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': exercise['name'],
        'muscle': exercise['muscle'],
        'type': exercise['type'],
        'equipment': exercise['equipment'],
        'sets': 3,
        'reps': 12,
        'weight': 0.0,
        'restTime': 60,
        'notes': '',
      });
    });
  }

  void _removeExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }

  void _editExercise(int index) {
    _showExerciseEditDialog(_exercises[index], index);
  }

  void _showAddExerciseDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Color(0xFF1D1D1D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Add Exercise',
                    style: Fonts.title.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search and Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SearchField(
                      controller: _searchController,
                      hintText: "Search exercises...",
                      onChanged: (value) {
                        _searchQuery = value;
                        _filterExercises();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedFilter,
                          dropdownColor: const Color(0xFF2A2A2A),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[400],
                          ),
                          style: Fonts.text.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          items: _filterOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFilter = newValue!;
                              _filterExercises();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Exercise List
            Expanded(
              child: _filteredExercises.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            color: Colors.grey[400],
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No exercises found',
                            style: Fonts.text.copyWith(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredExercises.length,
                      itemBuilder: (context, index) {
                        final exercise = _filteredExercises[index];
                        final isAlreadyAdded = _exercises.any(
                          (e) => e['name'] == exercise['name'],
                        );

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0x38FFFFFF),
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _getExerciseColor(
                                  exercise['type'],
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                _getExerciseIcon(exercise['type']),
                                color: _getExerciseColor(exercise['type']),
                                size: 20,
                              ),
                            ),
                            title: Text(
                              exercise['name'],
                              style: Fonts.text.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              '${exercise['muscle']} • ${exercise['type']}',
                              style: Fonts.text.copyWith(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: isAlreadyAdded
                                  ? null
                                  : () {
                                      _addExercise(exercise);
                                      Navigator.pop(context);
                                    },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isAlreadyAdded
                                      ? Colors.grey[700]
                                      : AppColors.primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  isAlreadyAdded ? Icons.check : Icons.add,
                                  color: isAlreadyAdded
                                      ? Colors.grey
                                      : AppColors.primaryColor,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseEditDialog(Map<String, dynamic> exercise, int index) {
    final TextEditingController setsController = TextEditingController(
      text: exercise['sets'].toString(),
    );
    final TextEditingController repsController = TextEditingController(
      text: exercise['reps'].toString(),
    );
    final TextEditingController weightController = TextEditingController(
      text: exercise['weight'].toString(),
    );
    final TextEditingController restController = TextEditingController(
      text: exercise['restTime'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1D1D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit ${exercise['name']}',
          style: Fonts.title.copyWith(color: Colors.white, fontSize: 18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: _buildEditField('Sets', setsController)),
                const SizedBox(width: 16),
                Expanded(child: _buildEditField('Reps', repsController)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildEditField('Weight (kg)', weightController),
                ),
                const SizedBox(width: 16),
                Expanded(child: _buildEditField('Rest (sec)', restController)),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: Fonts.text.copyWith(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _exercises[index]['sets'] =
                    int.tryParse(setsController.text) ?? 3;
                _exercises[index]['reps'] =
                    int.tryParse(repsController.text) ?? 12;
                _exercises[index]['weight'] =
                    double.tryParse(weightController.text) ?? 0.0;
                _exercises[index]['restTime'] =
                    int.tryParse(restController.text) ?? 60;
              });
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: Fonts.text.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: Fonts.text.copyWith(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Fonts.text.copyWith(color: AppColors.primaryColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Color _getExerciseColor(String type) {
    switch (type.toLowerCase()) {
      case 'strength':
        return Colors.blue;
      case 'bodyweight':
        return Colors.green;
      case 'cardio':
        return Colors.orange;
      case 'machine':
        return Colors.purple;
      default:
        return AppColors.primaryColor;
    }
  }

  IconData _getExerciseIcon(String type) {
    switch (type.toLowerCase()) {
      case 'strength':
        return Icons.fitness_center;
      case 'bodyweight':
        return Icons.accessibility_new;
      case 'cardio':
        return Icons.directions_run;
      case 'machine':
        return Icons.settings;
      default:
        return Icons.fitness_center;
    }
  }

  String _getDayOfWeek(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return 'MON';
      case 'tuesday':
        return 'TUE';
      case 'wednesday':
        return 'WED';
      case 'thursday':
        return 'THU';
      case 'friday':
        return 'FRI';
      case 'saturday':
        return 'SAT';
      case 'sunday':
        return 'SUN';
      default:
        return day.substring(0, 3).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          children: [
            // Header with background image
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1D1D1D),
                image: DecorationImage(
                  image: AssetImage("assets/images/exercise.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context, _exercises),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Day indicator
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0x38FFFFFF),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    _getDayOfWeek(widget.day),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                widget.workoutType,
                                style: Fonts.text.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),

                      // Exercise count
                      Text(
                        '${_exercises.length} Exercises',
                        style: Fonts.title.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content area
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF1D1D1D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Add Exercise Button
                      GestureDetector(
                        onTap: _showAddExerciseDialog,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Add Exercise',
                                style: Fonts.text.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Exercises List
                      if (_exercises.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fitness_center,
                                  color: Colors.grey[400],
                                  size: 48,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No exercises added yet',
                                  style: Fonts.text.copyWith(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tap "Add Exercise" to get started',
                                  style: Fonts.text.copyWith(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: ReorderableListView.builder(
                            itemCount: _exercises.length,
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (newIndex > oldIndex) {
                                  newIndex -= 1;
                                }
                                final item = _exercises.removeAt(oldIndex);
                                _exercises.insert(newIndex, item);
                              });
                            },
                            itemBuilder: (context, index) {
                              final exercise = _exercises[index];
                              return Container(
                                key: ValueKey(exercise['id']),
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0x38FFFFFF),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // Exercise Icon
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: _getExerciseColor(
                                          exercise['type'],
                                        ).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        _getExerciseIcon(exercise['type']),
                                        color: _getExerciseColor(
                                          exercise['type'],
                                        ),
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Exercise Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exercise['name'],
                                            style: Fonts.text.copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${exercise['sets']} sets • ${exercise['reps']} reps',
                                            style: Fonts.text.copyWith(
                                              color: Colors.grey[400],
                                              fontSize: 12,
                                            ),
                                          ),
                                          if (exercise['weight'] > 0) ...[
                                            const SizedBox(height: 2),
                                            Text(
                                              '${exercise['weight']}kg • ${exercise['restTime']}s rest',
                                              style: Fonts.text.copyWith(
                                                color: AppColors.primaryColor,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),

                                    // Action Buttons
                                    GestureDetector(
                                      onTap: () => _editExercise(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.grey[400],
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => _removeExercise(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.drag_handle,
                                      color: Colors.grey[400],
                                      size: 18,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                      // Save Button
                      const SizedBox(height: 16),
                      CustomButton(
                        fontSize: 16,
                        height: 14,
                        text: 'Save Exercises (${_exercises.length})',
                        color: AppColors.primaryColor,
                        textColor: Colors.black,
                        onPressed: () {
                          Navigator.pop(context, _exercises);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
