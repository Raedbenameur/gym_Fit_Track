import 'package:flutter/material.dart';
import 'package:gym/widgets/app_bar_button.dart';
import '../core/colors.dart';
import '../core/fonts.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Sample data - replace with your data source
  final List<Map<String, dynamic>> activeGoals = [
    {
      'title': 'Bench Press 100kg × 5 reps',
      'type': 'Strength',
      'target': '100kg × 5',
      'current': '85kg × 5',
      'progress': 0.75,
      'deadline': DateTime(2024, 10, 1),
      'status': 'Active',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Lose 3kg',
      'type': 'Weight Loss',
      'target': '75kg',
      'current': '76.5kg',
      'progress': 0.5,
      'deadline': DateTime(2024, 9, 15),
      'status': 'Active',
      'icon': Icons.scale,
    },
    {
      'title': 'Workout 4 times per week',
      'type': 'Frequency',
      'target': '16 workouts/month',
      'current': '12 workouts',
      'progress': 0.75,
      'deadline': DateTime(2024, 8, 31),
      'status': 'Active',
      'icon': Icons.event_repeat,
    },
  ];

  final List<Map<String, dynamic>> completedGoals = [
    {
      'title': 'Squat 120kg × 3 reps',
      'type': 'Strength',
      'target': '120kg × 3',
      'completedDate': DateTime(2024, 7, 20),
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Run 5km under 25 minutes',
      'type': 'Cardio',
      'target': '24:30 min',
      'completedDate': DateTime(2024, 6, 15),
      'icon': Icons.directions_run,
    },
  ];

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set New Goal',
                      style: Fonts.title.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildGoalTypeButton('Exercise Volume', Icons.fitness_center),
                const SizedBox(height: 12),
                _buildGoalTypeButton('Frequency Goal', Icons.event_repeat),
                const SizedBox(height: 12),
                _buildGoalTypeButton('Body Goal', Icons.person),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGoalTypeButton(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // Navigate to specific goal creation screen
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Fonts.text.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Goals',
                          style: Fonts.title.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Track your fitness journey',
                          style: Fonts.text.copyWith(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add Goal Button
                  AppBarButton(
                    icon: const Icon(Icons.add, color: Colors.black, size: 28),
                    onPressed: _showAddGoalDialog,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Overview Stats
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      '${activeGoals.length}',
                      'Active\nGoals',
                      Icons.flag,
                    ),
                    _buildStatItem(
                      '${completedGoals.length}',
                      'Completed\nGoals',
                      Icons.check_circle,
                    ),
                    _buildStatItem('75%', 'Avg\nProgress', Icons.trending_up),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tab Bar
              // Tab Bar
              Container(
                height: 45,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey[800]!, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors
                        .primaryColor, // Fixed: This is the indicator background color
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab, // Add this line
                  indicatorPadding: EdgeInsets.zero,
                  labelColor: Colors
                      .black, // Text color when selected (on primary color)
                  unselectedLabelColor:
                      Colors.grey[400], // Text color when not selected
                  labelStyle: Fonts.text.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    letterSpacing: 0.5,
                  ),
                  unselectedLabelStyle: Fonts.text.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  tabs: const [
                    Tab(child: Text('Active', style: TextStyle(inherit: true))),
                    Tab(
                      child: Text('Completed', style: TextStyle(inherit: true)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Active Goals Tab
                    activeGoals.isEmpty
                        ? _buildEmptyState(
                            'No Active Goals',
                            'Set your first goal to start tracking your progress',
                            Icons.flag_outlined,
                          )
                        : ListView.builder(
                            itemCount: activeGoals.length,
                            itemBuilder: (context, index) {
                              final goal = activeGoals[index];
                              return _buildActiveGoalCard(goal);
                            },
                          ),
                    // Completed Goals Tab
                    completedGoals.isEmpty
                        ? _buildEmptyState(
                            'No Completed Goals',
                            'Complete your first goal to see it here',
                            Icons.emoji_events_outlined,
                          )
                        : ListView.builder(
                            itemCount: completedGoals.length,
                            itemBuilder: (context, index) {
                              final goal = completedGoals[index];
                              return _buildCompletedGoalCard(goal);
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            title,
            style: Fonts.title.copyWith(
              color: Colors.grey[400],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Fonts.text.copyWith(color: Colors.grey[500], fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryColor, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Fonts.title.copyWith(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActiveGoalCard(Map<String, dynamic> goal) {
    final progress = goal['progress'] as double;
    final daysLeft = goal['deadline'].difference(DateTime.now()).inDays;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  goal['icon'],
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'],
                      style: Fonts.title.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      goal['type'],
                      style: Fonts.text.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: daysLeft > 7
                      ? Colors.green.withOpacity(0.2)
                      : daysLeft > 0
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: daysLeft > 7
                        ? Colors.green
                        : daysLeft > 0
                        ? Colors.orange
                        : Colors.red,
                    width: 1,
                  ),
                ),
                child: Text(
                  daysLeft > 0 ? '$daysLeft days left' : 'Overdue',
                  style: Fonts.text.copyWith(
                    color: daysLeft > 7
                        ? Colors.green
                        : daysLeft > 0
                        ? Colors.orange
                        : Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: Fonts.text.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: Fonts.text.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.grey[700],
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Current vs Target
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current',
                      style: Fonts.text.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      goal['current'],
                      style: Fonts.text.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Target',
                      style: Fonts.text.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      goal['target'],
                      style: Fonts.text.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedGoalCard(Map<String, dynamic> goal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Trophy Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.green.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.green,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal['title'],
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Target: ${goal['target']}',
                  style: Fonts.text.copyWith(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.green, size: 12),
                    const SizedBox(width: 4),
                    Text(
                      'Completed: ${_formatDate(goal['completedDate'])}',
                      style: Fonts.text.copyWith(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Checkmark
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
