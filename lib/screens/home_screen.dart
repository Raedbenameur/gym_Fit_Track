import 'package:flutter/material.dart';
import 'package:gym/routes.dart';
import 'package:gym/screens/settings_screen.dart';
import 'package:gym/widgets/app_bar_button.dart';
import 'package:gym/widgets/home/calendar.dart';
import 'package:gym/widgets/home/daily_motivation.dart';
import 'package:gym/widgets/home/quick_action.dart';
import 'package:gym/widgets/home/stat_item.dart';
import 'package:gym/widgets/home/workout_card.dart';

import '../core/colors.dart';
import '../core/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void _showCalendarDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 500),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Workout Calendar',
                        style: Fonts.title.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: WorkoutCalendar(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAchievementCard(
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: Fonts.text.copyWith(
                    color: Colors.grey[400],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1C1C),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting & Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: Fonts.title.copyWith(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ready for today\'s workout?',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  AppBarButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 28,
                    ),
                    onPressed: () async {
                      if (context.mounted) {
                        await Routes.slideFromRight(
                          context,
                          const SettingsScreen(),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DailyMotivation(),

              const SizedBox(height: 20),

              // Action button with calendar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
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
                          GestureDetector(
                            onTap: () => _showCalendarDialog(),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                child: Text(
                                  "SAT",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Time to workout',
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
                ],
              ),
              SizedBox(height: 20),
              // Quick Stats
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItem(
                      value: '156',
                      label: 'Total\nWorkouts',
                      icon: Icons.fitness_center,
                    ),
                    StatItem(
                      icon: Icons.local_fire_department, // Fire icon
                      value: "107", // Days streak value
                      label: "Days\nStreak",
                      delay: const Duration(milliseconds: 400),
                      isFireIcon: true, // Enable fire animation
                    ),
                    StatItem(
                      value: '178',
                      label: 'Hours\nTrained',
                      icon: Icons.access_time_outlined,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: QuickAction(
                      title: 'Start\nWorkout',
                      icon: Icons.play_arrow,
                      onTap: () {},
                      isStartWorkout: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickAction(
                      title: 'View\nProgress',
                      icon: Icons.insights,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: QuickAction(
                      title: 'Set\nGoals',
                      icon: Icons.flag,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Today's Plan Section
              Row(
                children: [
                  Text(
                    "TODAY'S PLAN",
                    style: Fonts.subtitle.copyWith(
                      fontSize: 11,
                      color: const Color(0xFF959595),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(height: 1, color: const Color(0xFF959595)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Workout Card
              const WorkoutCard(),
              const SizedBox(height: 24),

              // Recent Achievements
              Text(
                'Recent Achievements 🏆',
                style: Fonts.title.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildAchievementCard(
                'First Week Complete!',
                'Completed 7 consecutive days',
                Icons.check_circle,
              ),
              _buildAchievementCard(
                'Consistency King',
                'Maintained 21-day streak',
                Icons.trending_up,
              ),
              _buildAchievementCard(
                'Early Bird',
                'Completed 5 morning workouts',
                Icons.wb_sunny,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
