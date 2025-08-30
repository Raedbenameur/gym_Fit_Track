import 'package:flutter/material.dart';
import 'package:gym/widgets/app_bar_button.dart';
import 'package:gym/widgets/programs/program_card.dart';
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

  void _showAddProgramDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Program',
                  style: Fonts.title.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'This feature will allow you to create custom workout programs',
                  style: Fonts.text.copyWith(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to add program screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Create'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
              // Header with Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Workout Programs',
                          style: Fonts.title.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Create and manage your workout plans',
                          style: Fonts.subtitle.copyWith(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Add Program Button
                  AppBarButton(
                    icon: const Icon(Icons.add, color: Colors.black, size: 28),
                    onPressed: _showAddProgramDialog,
                  ),
                ],
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
                height: 36,
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
                              fontSize: 12,
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
                          return ProgramCard(program: program);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
