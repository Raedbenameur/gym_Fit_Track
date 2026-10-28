import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/widgets/add_exercise.dart';

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

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.exercises);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with background image
              Container(
                height: 500,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/exercise.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Top section with back button
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context, _exercises),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(
                                  255,
                                  96,
                                  96,
                                  96,
                                ).withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),

                          // Exercise count indicator
                        ],
                      ),

                      const Spacer(),

                      // Center content
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Day badge
                          Text(
                            widget.day,
                            style: Fonts.title.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),

                          // Workout type title
                          Text(
                            widget.workoutType,
                            textAlign: TextAlign.center,
                            style: Fonts.subtitle.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Subtitle
                          Text(
                            'Build strength and endurance',
                            style: Fonts.text.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Bottom action row
                    ],
                  ),
                ),
              ),

              AddExercise(exercises: widget.exercises),
            ],
          ),
        ),
      ),
    );
  }
}
