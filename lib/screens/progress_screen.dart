import 'package:flutter/material.dart';
import 'package:gym/widgets/search_field.dart';
import '../core/colors.dart';
import '../core/fonts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // Sample workout history data
  final List<Map<String, dynamic>> workoutHistory = [
    {
      'date': '2024-08-26',
      'title': 'Chest & Triceps',
      'completed': true,
      'duration': 55,
      'exercises': [
        {
          'name': 'Bench Press',
          'sets': ['12×60kg', '10×65kg', '8×70kg', '6×75kg'],
          'type': 'Strength',
        },
        {
          'name': 'Incline Dumbbell Press',
          'sets': ['12×25kg', '10×27.5kg', '8×30kg'],
          'type': 'Strength',
        },
        {
          'name': 'Push Ups',
          'sets': ['15 reps', '12 reps', '10 reps'],
          'type': 'Bodyweight',
        },
        {
          'name': 'Tricep Dips',
          'sets': ['15 reps', '12 reps', '10 reps', '8 reps'],
          'type': 'Bodyweight',
        },
      ],
    },
    {
      'date': '2024-08-24',
      'title': 'Legs',
      'completed': true,
      'duration': 65,
      'exercises': [
        {
          'name': 'Squat',
          'sets': ['15×80kg', '12×90kg', '10×100kg', '8×110kg'],
          'type': 'Strength',
        },
        {
          'name': 'Romanian Deadlift',
          'sets': ['12×70kg', '10×80kg', '8×90kg'],
          'type': 'Strength',
        },
        {
          'name': 'Leg Press',
          'sets': ['15×120kg', '12×140kg', '10×160kg'],
          'type': 'Machine',
        },
        {
          'name': 'Walking Lunges',
          'sets': ['12 each leg', '10 each leg', '8 each leg'],
          'type': 'Bodyweight',
        },
      ],
    },
    {
      'date': '2024-08-22',
      'title': 'Back & Biceps',
      'completed': true,
      'duration': 50,
      'exercises': [
        {
          'name': 'Pull Ups',
          'sets': ['8 reps', '6 reps', '5 reps', '4 reps'],
          'type': 'Bodyweight',
        },
        {
          'name': 'Barbell Rows',
          'sets': ['12×60kg', '10×70kg', '8×80kg'],
          'type': 'Strength',
        },
        {
          'name': 'Lat Pulldown',
          'sets': ['12×50kg', '10×55kg', '8×60kg'],
          'type': 'Machine',
        },
        {
          'name': 'Bicep Curls',
          'sets': ['15×15kg', '12×17.5kg', '10×20kg'],
          'type': 'Strength',
        },
      ],
    },
    {
      'date': '2024-08-20',
      'title': 'Shoulders & Core',
      'completed': true,
      'duration': 45,
      'exercises': [
        {
          'name': 'Overhead Press',
          'sets': ['12×40kg', '10×45kg', '8×50kg'],
          'type': 'Strength',
        },
        {
          'name': 'Lateral Raises',
          'sets': ['15×10kg', '12×12.5kg', '10×15kg'],
          'type': 'Strength',
        },
        {
          'name': 'Plank',
          'sets': ['60s', '45s', '30s'],
          'type': 'Core',
        },
      ],
    },
  ];

  // Personal bests data
  final Map<String, Map<String, dynamic>> personalBests = {
    'Bench Press': {'weight': '75kg', 'reps': 6, 'date': '2024-08-26'},
    'Squat': {'weight': '110kg', 'reps': 8, 'date': '2024-08-24'},
    'Deadlift': {'weight': '140kg', 'reps': 5, 'date': '2024-08-18'},
    'Overhead Press': {'weight': '50kg', 'reps': 8, 'date': '2024-08-20'},
    'Pull Ups': {'weight': 'Bodyweight', 'reps': 8, 'date': '2024-08-22'},
  };

  // Statistics data
  final Map<String, dynamic> statistics = {
    'totalWorkouts': 47,
    'totalHours': 52.5,
    'currentStreak': 7,
    'longestStreak': 14,
    'averageWorkoutTime': 48,
    'favoriteExercise': 'Bench Press',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progress & History',
                          style: Fonts.title.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Track your fitness journey',
                          style: Fonts.text.copyWith(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Tab Bar
              Container(
                height: 45,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.zero,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[400],
                  labelStyle: Fonts.subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                  unselectedLabelStyle: Fonts.subtitle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  tabs: const [
                    Tab(text: 'History'),
                    Tab(text: 'Statistics'),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildHistoryTab(), _buildStatisticsTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      children: [
        // Search and Filter Section
        SearchField(
          controller: searchController,
          hintText: "Search exercices...",

          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        const SizedBox(height: 16),

        // Workout History List
        Expanded(
          child: ListView.builder(
            itemCount: workoutHistory.length,
            itemBuilder: (context, index) {
              final workout = workoutHistory[index];
              return _buildWorkoutHistoryCard(workout);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Statistics Overview
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Statistics',
                style: Fonts.title.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Workouts',
                      '${statistics['totalWorkouts']}',
                      Icons.fitness_center,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Hours Trained',
                      '${statistics['totalHours']}h',
                      Icons.timer,
                      Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Current Streak',
                      '${statistics['currentStreak']} days',
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      'Longest Streak',
                      '${statistics['longestStreak']} days',
                      Icons.emoji_events,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Personal Bests
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.emoji_events,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Personal Bests',
                      style: Fonts.title.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...personalBests.entries.map(
                  (entry) => _buildPersonalBestItem(entry.key, entry.value),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Volume Trend (Simple representation)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly Volume Trend',
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildVolumeChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutHistoryCard(Map<String, dynamic> workout) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.all(16),
                childrenPadding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                leading: Container(
                  padding: const EdgeInsets.all(8),

                  child: Icon(
                    workout['completed'] ? Icons.check_circle : Icons.schedule,
                    color: workout['completed'] ? Colors.green : Colors.grey,
                    size: 20,
                  ),
                ),
                title: Text(
                  workout['title'],
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(workout['date']),
                      style: Fonts.text.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${workout['exercises'].length} exercises • ${workout['duration']} min',
                      style: Fonts.text.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Icon(Icons.expand_more, color: Colors.grey[400]),
                children: [
                  const SizedBox(height: 8),
                  ...workout['exercises'].map<Widget>(
                    (exercise) => _buildExerciseDetail(exercise),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExerciseDetail(Map<String, dynamic> exercise) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise['name'],
                  style: Fonts.text.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  exercise['type'],
                  style: Fonts.text.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: (exercise['sets'] as List<String>).map((set) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  set,
                  style: Fonts.text.copyWith(color: Colors.white, fontSize: 11),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Fonts.title.copyWith(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalBestItem(String exercise, Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF3A3A3A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.emoji_events,
              color: AppColors.primaryColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise,
                  style: Fonts.text.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(data['date']),
                  style: Fonts.text.copyWith(
                    color: Colors.grey[400],
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${data['weight']} × ${data['reps']}',
            style: Fonts.text.copyWith(
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeChart() {
    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
    final values = [0.6, 0.8, 0.7, 0.9];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (index) {
        return Column(
          children: [
            Container(
              width: 40,
              height: 80 * values[index],
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              weeks[index],
              style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 11),
            ),
          ],
        );
      }),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
