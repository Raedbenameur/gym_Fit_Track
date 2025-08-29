import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/fonts.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  String selectedFilter = 'All';
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  final List<String> filters = [
    'All',
    'Strength',
    'Weight Loss',
    'Endurance',
    'Muscle Gain',
  ];

  final List<Map<String, dynamic>> programs = [
    {
      'name': 'Full Body Shred',
      'goal': 'Lose weight & tone in 4 weeks',
      'duration': '4 weeks, 3 days/week',
      'level': 'Intermediate',
      'category': 'Weight Loss',
      'progress': 0.65,
      'isStarted': true,
      'image': 'assets/images/program1.jpg',
    },
    {
      'name': 'Strength Builder',
      'goal': 'Build muscle & increase power',
      'duration': '8 weeks, 4 days/week',
      'level': 'Advanced',
      'category': 'Strength',
      'progress': 0.0,
      'isStarted': false,
      'image': 'assets/images/program2.jpg',
    },
    {
      'name': 'Cardio Blast',
      'goal': 'Improve cardiovascular health',
      'duration': '6 weeks, 5 days/week',
      'level': 'Beginner',
      'category': 'Endurance',
      'progress': 0.3,
      'isStarted': true,
      'image': 'assets/images/program3.jpg',
    },
    {
      'name': 'Lean Mass Gainer',
      'goal': 'Build lean muscle mass',
      'duration': '12 weeks, 4 days/week',
      'level': 'Intermediate',
      'category': 'Muscle Gain',
      'progress': 0.0,
      'isStarted': false,
      'image': 'assets/images/program4.jpg',
    },
    {
      'name': 'Beginner\'s Journey',
      'goal': 'Start your fitness journey',
      'duration': '3 weeks, 3 days/week',
      'level': 'Beginner',
      'category': 'Strength',
      'progress': 0.8,
      'isStarted': true,
      'image': 'assets/images/program5.jpg',
    },
  ];

  List<Map<String, dynamic>> get filteredPrograms {
    return programs.where((program) {
      final matchesFilter =
          selectedFilter == 'All' || program['category'] == selectedFilter;
      final matchesSearch =
          program['name'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          program['goal'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

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
              Text(
                'Workout Programs',
                style: Fonts.title.copyWith(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find the perfect program for your goals',
                style: Fonts.text.copyWith(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  style: Fonts.text.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search programs...',
                    hintStyle: Fonts.text.copyWith(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Filter Chips
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filters.length,
                  itemBuilder: (context, index) {
                    final filter = filters[index];
                    final isSelected = selectedFilter == filter;

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey[600]!,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            filter,
                            style: Fonts.text.copyWith(
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Programs List
              Expanded(
                child: filteredPrograms.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No programs found',
                              style: Fonts.title.copyWith(
                                color: Colors.grey[600],
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try adjusting your search or filters',
                              style: Fonts.text.copyWith(
                                color: Colors.grey[500],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredPrograms.length,
                        itemBuilder: (context, index) {
                          final program = filteredPrograms[index];
                          return _buildProgramCard(program);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgramCard(Map<String, dynamic> program) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.8),
                  AppColors.primaryColor.withOpacity(0.4),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Level Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
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
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Progress indicator for started programs
                if (program['isStarted'])
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'In Progress',
                        style: Fonts.text.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Play button
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Program Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Program Name
                Text(
                  program['name'],
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Goal Tagline
                Text(
                  program['goal'],
                  style: Fonts.text.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 14,
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
                        fontSize: 14,
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
                        style: Fonts.text.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(program['progress'] * 100).toInt()}%',
                        style: Fonts.text.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to program details
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: program['isStarted']
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      foregroundColor: program['isStarted']
                          ? Colors.black
                          : AppColors.primaryColor,
                      side: program['isStarted']
                          ? null
                          : BorderSide(color: AppColors.primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      program['isStarted'] ? 'Continue' : 'Start Program',
                      style: Fonts.text.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
