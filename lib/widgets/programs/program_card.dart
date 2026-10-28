import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/widgets/costum_button.dart';

class ProgramCard extends StatelessWidget {
  final Map<String, dynamic> program;
  const ProgramCard({super.key, required this.program});
  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Program Image
          Container(
            height: 150,
            width: double.infinity,

            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/download.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Program Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Program Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      program['name'],
                      style: Fonts.title.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getLevelColor(program['level']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        program['level'],
                        style: Fonts.text.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Goal Tagline
                Text(
                  program['goal'],
                  style: Fonts.subtitle.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Duration & Level Info
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.grey[400], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      program['duration'],
                      style: Fonts.text.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Progress Bar (if started)
                if (program['isStarted']) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: Fonts.subtitle.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${(program['progress'] * 100).toInt()}%',
                        style: Fonts.subtitle.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(6),
                    value: program['progress'],
                    backgroundColor: Colors.grey[600],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor,
                    ),
                    minHeight: 6,
                  ),
                  const SizedBox(height: 16),
                ],

                // Action Button
                CustomButton(
                  fontSize: 14,
                  height: 12,
                  text: program['isStarted'] ? 'Continue' : 'Start Program',
                  color: program['isStarted']
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  textColor: program['isStarted']
                      ? Colors.black
                      : AppColors.primaryColor,
                  borderColor: program['isStarted']
                      ? null
                      : AppColors.primaryColor,
                  borderWidth: program['isStarted'] ? null : 1.5,
                  onPressed: () {
                    // Navigate to program details
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
