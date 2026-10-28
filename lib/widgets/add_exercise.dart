import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

import 'package:gym/widgets/costum_button.dart';
import 'package:gym/widgets/programs/custom_field.dart';

class AddExercise extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;
  const AddExercise({super.key, required this.exercises});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.exercises);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _addCustomExercise() {
    showDialog(
      context: context,
      builder: (context) => _buildCustomExerciseDialog(),
    );
  }

  void _addRestPeriod() {
    showDialog(context: context, builder: (context) => _buildRestDialog());
  }

  Widget _buildCustomExerciseDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController setsController = TextEditingController(
      text: '3',
    );
    final TextEditingController repsController = TextEditingController(
      text: '12',
    );
    final TextEditingController restController = TextEditingController(
      text: '60',
    );

    return AlertDialog(
      backgroundColor: const Color(0xFF1D1D1D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.add_circle, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 8),
          Text(
            'Create Custom Exercise',
            style: Fonts.title.copyWith(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Name
          CustomField(
            controller: nameController,
            hintText: "Enter exercise name",
            labelText: "Exercise Name",
            required: true,
          ),

          const SizedBox(height: 8),
          // Description
          CustomField(
            controller: descriptionController,
            hintText: "How to perform this exercise",
            labelText: 'Description',
            maxLines: 3,
          ),
          const SizedBox(height: 8),

          // Volume (Weight)
          CustomField(
            controller: weightController,
            hintText: "20 kg",
            labelText: 'Weight',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // Sets and Reps
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      controller: setsController,
                      hintText: "3",
                      labelText: 'Sets',
                      keyboardType: TextInputType.number,
                      required: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField(
                      controller: repsController,
                      hintText: "12",
                      labelText: 'Reps',
                      keyboardType: TextInputType.number,
                      required: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rest Time
          CustomField(
            controller: restController,
            hintText: "60 seconds",
            labelText: 'Rest Time (seconds)',
            keyboardType: TextInputType.number,
            required: true,
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
            if (nameController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Exercise name is required'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final newExercise = {
              'id': DateTime.now().millisecondsSinceEpoch.toString(),
              'name': nameController.text.trim(),
              'type': 'Custom',
              'equipment': 'Custom',
              'description': descriptionController.text.trim(),
              'sets': int.tryParse(setsController.text) ?? 3,
              'reps': int.tryParse(repsController.text) ?? 12,
              'weight': double.tryParse(weightController.text) ?? 0.0,
              'restTime': int.tryParse(restController.text) ?? 60,
              'notes': '',
            };

            // Use the main widget's setState instead of the StatefulBuilder's setState
            setState(() {
              _exercises.add(newExercise);
            });

            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${nameController.text} added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          child: Text(
            'Add Exercise',
            style: Fonts.text.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildRestDialog() {
    String selectedRestTime = '60';
    final List<String> restOptions = ['30', '60', '90', '120', '180'];
    final TextEditingController customRestController = TextEditingController();

    return StatefulBuilder(
      builder: (context, setDialogState) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1D1D1D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.timer, color: Colors.orange, size: 24),
              const SizedBox(width: 8),
              Text(
                'Add Rest Period',
                style: Fonts.title.copyWith(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select rest duration:',
                style: Fonts.text.copyWith(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [...restOptions, 'Custom'].map((time) {
                  final isSelected = selectedRestTime == time;
                  return GestureDetector(
                    onTap: () {
                      setDialogState(() {
                        selectedRestTime = time;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orange.withValues(alpha: 0.2)
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.orange : Colors.grey[600]!,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        time == 'Custom' ? time : '${time}s',
                        style: Fonts.text.copyWith(
                          color: isSelected ? Colors.orange : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (selectedRestTime == 'Custom') ...[
                const SizedBox(height: 16),
                CustomField(
                  controller: customRestController,
                  hintText: "Enter custom rest time in seconds",
                  labelText: 'Custom Rest Time',
                  keyboardType: TextInputType.number,
                ),
              ],
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
                int restTime;
                if (selectedRestTime == 'Custom') {
                  restTime = int.tryParse(customRestController.text) ?? 60;
                  if (customRestController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a custom rest time'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                } else {
                  restTime = int.parse(selectedRestTime);
                }

                // Use the main widget's setState instead of the StatefulBuilder's setState
                setState(() {
                  _exercises.add({
                    'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    'name': 'Rest Period',
                    'type': 'rest',
                    'duration': restTime,
                    'isRest': true,
                  });
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${restTime}s rest period added!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: Text(
                'Add Rest',
                style: Fonts.text.copyWith(color: Colors.orange),
              ),
            ),
          ],
        );
      },
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
      case 'custom':
        return AppColors.primaryColor;
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
      case 'custom':
        return Icons.star;
      default:
        return Icons.fitness_center;
    }
  }

  void _removeExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
    });
  }
  /* void _editExercise(int index) {
    // Your existing edit method
  }
 */

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // Action Buttons
            Row(
              children: [
                // Add Exercise Button
                Expanded(
                  child: GestureDetector(
                    onTap: _addCustomExercise,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Add Exercise',
                            style: Fonts.text.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Add Rest Button
                GestureDetector(
                  onTap: _addRestPeriod,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: Colors.orange, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'Add Rest',
                          style: Fonts.text.copyWith(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Exercises List
            if (_exercises.isEmpty)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,

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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  final isLast = index == _exercises.length - 1;

                  return Container(
                    key: ValueKey(exercise['id']),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Number Circle with connecting line
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: exercise['isRest'] == true
                                  ? Colors.orange
                                  : AppColors.primaryColor,
                              child: exercise['isRest'] == true
                                  ? Icon(
                                      Icons.timer,
                                      color: Colors.black,
                                      size: 16,
                                    )
                                  : Text(
                                      (index + 1).toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 50,
                                color: Colors.grey[600],
                                margin: const EdgeInsets.symmetric(vertical: 4),
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),

                        // Exercise Card
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: exercise['isRest'] == true
                                  ? const Color(0xFF2A1F1A)
                                  : const Color(0xFF2A2A2A),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: exercise['isRest'] == true
                                    ? Colors.orange.withValues(alpha: 0.3)
                                    : const Color(0x38FFFFFF),
                                width: 1,
                              ),
                            ),
                            child: exercise['isRest'] == true
                                ? _buildRestItem(exercise, index)
                                : _buildExerciseItem(exercise, index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
    );
  }

  Widget _buildRestItem(Map<String, dynamic> rest, int index) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rest Period',
                style: Fonts.text.copyWith(
                  color: Colors.orange,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${rest['duration']} seconds break',
                style: Fonts.text.copyWith(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => _removeExercise(index),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.red,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseItem(Map<String, dynamic> exercise, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Exercise Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _getExerciseColor(
                  exercise['type'],
                ).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                _getExerciseIcon(exercise['type']),
                color: _getExerciseColor(exercise['type']),
                size: 14,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                exercise['name'],
                style: Fonts.text.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _removeExercise(index),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 16,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Exercise Details
        if (exercise['description'] != null &&
            exercise['description'].isNotEmpty) ...[
          Text(
            exercise['description'],
            style: Fonts.text.copyWith(color: Colors.grey[300], fontSize: 12),
          ),
          const SizedBox(height: 8),
        ],

        Row(
          children: [
            _buildDetailChip('${exercise['sets']} sets', Colors.blue),
            const SizedBox(width: 8),
            _buildDetailChip('${exercise['reps']} reps', Colors.green),
            if (exercise['weight'] > 0) ...[
              const SizedBox(width: 8),
              _buildDetailChip('${exercise['weight']}kg', Colors.orange),
            ],
            const SizedBox(width: 8),
            _buildDetailChip('${exercise['restTime']}s rest', Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        text,
        style: Fonts.text.copyWith(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
