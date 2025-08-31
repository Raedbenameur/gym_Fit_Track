import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/screens/programs/program_days.dart';
import 'package:gym/widgets/app_bar.dart' as custom_app_bar;
import 'package:gym/widgets/costum_button.dart';
import 'package:gym/widgets/programs/custom_field.dart';

import '../../routes.dart';

class NewProgramScreen extends StatefulWidget {
  const NewProgramScreen({super.key});

  @override
  State<NewProgramScreen> createState() => _NewProgramScreenState();
}

class _NewProgramScreenState extends State<NewProgramScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _customTypeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedType;
  bool _isCustomType = false;

  final List<Map<String, dynamic>> _programTypes = [
    {'name': 'Muscle Gain', 'icon': Icons.fitness_center, 'color': Colors.blue},
    {
      'name': 'Weight Loss',
      'icon': Icons.local_fire_department,
      'color': Colors.orange,
    },
    {'name': 'Strength', 'icon': Icons.trending_up, 'color': Colors.green},
    {'name': 'Endurance', 'icon': Icons.directions_run, 'color': Colors.purple},
    {
      'name': 'Flexibility',
      'icon': Icons.self_improvement,
      'color': Colors.pink,
    },
    {'name': 'General Fitness', 'icon': Icons.favorite, 'color': Colors.red},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _customTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 28, 28),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                custom_app_bar.AppBar(
                  title: 'Create New Program',
                  subtitle: 'Design your custom workout program',
                ),
                const SizedBox(height: 32),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Program Name
                        CustomField(
                          controller: _nameController,
                          labelText: 'Program Name',
                          hintText: 'Enter program name...',

                          required: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Program name is required';
                            }
                            if (value.trim().length < 3) {
                              return 'Program name must be at least 3 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Description
                        CustomField(
                          controller: _descriptionController,
                          labelText: 'Description',
                          hintText:
                              'Describe your program goals and approach...',
                          prefixIcon: Icons.description,
                          maxLines: 4,
                          maxLength: 200,
                        ),
                        const SizedBox(height: 24),

                        // Program Type
                        Text(
                          'Program Type',
                          style: Fonts.text.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Predefined Types
                        Text(
                          'Choose from preset types :',
                          style: Fonts.text.copyWith(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 3,
                              ),
                          itemCount: _programTypes.length,
                          itemBuilder: (context, index) {
                            final type = _programTypes[index];
                            final isSelected =
                                _selectedType == type['name'] && !_isCustomType;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedType = type['name'];
                                  _isCustomType = false;
                                  _customTypeController.clear();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? type['color'].withOpacity(0.2)
                                      : const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? type['color']
                                        : Colors.grey[700]!,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      type['icon'],
                                      color: isSelected
                                          ? type['color']
                                          : Colors.grey[400],
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        type['name'],
                                        style: Fonts.text.copyWith(
                                          color: isSelected
                                              ? type['color']
                                              : Colors.white,
                                          fontSize: 12,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check_circle,
                                        color: type['color'],
                                        size: 16,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // Custom Type Section
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[700])),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'OR',
                                style: Fonts.text.copyWith(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[700])),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Create custom type :',
                          style: Fonts.text.copyWith(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),

                        CustomField(
                          controller: _customTypeController,

                          hintText: 'Enter custom type...',

                          maxLength: 20,
                          borderColor: _isCustomType
                              ? AppColors.primaryColor
                              : null,
                          focusedBorderColor: AppColors.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _isCustomType = value.isNotEmpty;
                              if (value.isNotEmpty) {
                                _selectedType = null;
                              }
                            });
                          },
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),

                // Create Button
                const SizedBox(height: 10),
                CustomButton(
                  fontSize: 14,
                  height: 12,
                  text: 'Continue ',
                  color: AppColors.primaryColor,
                  icon: Icons.arrow_forward,

                  textColor: Colors.black,

                  onPressed: () async {
                    if (context.mounted) {
                      await Routes.slideFromRight(
                        context,
                        const ProgramDaysScreen(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
