import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';
import 'package:gym/screens/programs/program_days.dart';
import 'package:gym/widgets/app_bar.dart' as custom_app_bar;
import 'package:gym/widgets/costum_button.dart';
import 'package:gym/widgets/image.dart';
import 'package:gym/widgets/programs/custom_field.dart';
import '../../core/utils/program_types.dart';

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
  String? _selectedDifficulty;
  String? _selectedPeriod;
  final ProgramTypes _programTypesProvider = ProgramTypes();
  List<Map<String, dynamic>> get _difficultyLevels =>
      _programTypesProvider.difficultyLevels;

  List<Map<String, dynamic>> get _periodOptions =>
      _programTypesProvider.periodOptions;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _customTypeController.dispose();
    super.dispose();
  }

  Widget _buildDifficultySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficulty Level',
          style: Fonts.text.copyWith(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Select your fitness level:',
          style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 14),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3,
          ),
          itemCount: _difficultyLevels.length,
          itemBuilder: (context, index) {
            final difficulty = _difficultyLevels[index];
            final isSelected = _selectedDifficulty == difficulty['name'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDifficulty = difficulty['name'];
                });
              },

              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.transparent
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? difficulty['color'] : Colors.grey[700]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        difficulty['name'],
                        style: Fonts.subtitle.copyWith(
                          color: isSelected
                              ? difficulty['color']
                              : Colors.white,
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.done, color: difficulty['color'], size: 18),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPeriodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Program Duration',
          style: Fonts.text.copyWith(
            color: AppColors.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'How long will this program run?',
          style: Fonts.text.copyWith(color: Colors.grey[400], fontSize: 14),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: _periodOptions.length,
          itemBuilder: (context, index) {
            final period = _periodOptions[index];
            final isSelected = _selectedPeriod == period['value'];

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedPeriod = period['value'];
                });

                if (period['value'] == 'custom') {
                  _showCustomPeriodDialog();
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Color(0xFF00B7C4).withOpacity(0.2)
                      : const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey[700]!,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          period['icon'],
                          color: isSelected
                              ? Color(0xFFFDDD48)
                              : Colors.grey[400],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            period['name'],
                            style: Fonts.text.copyWith(
                              color: isSelected
                                  ? Color(0xFFFDDD48)
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
                            color: Color(0xFFFDDD48),
                            size: 16,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      period['description'],
                      style: Fonts.text.copyWith(
                        color: Colors.grey[500],
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showCustomPeriodDialog() {
    final TextEditingController customPeriodController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1D1D1D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.edit_calendar, color: AppColors.primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              'Custom Duration',
              style: Fonts.title.copyWith(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomField(
              controller: customPeriodController,
              hintText: "Enter weeks (e.g., 20)",
              labelText: 'Duration in weeks',
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedPeriod = null;
              });
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: Fonts.text.copyWith(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              if (customPeriodController.text.trim().isNotEmpty) {
                setState(() {
                  _selectedPeriod = customPeriodController.text.trim();
                });
                Navigator.pop(context);
              }
            },
            child: Text(
              'Set Duration',
              style: Fonts.text.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() {
    return _nameController.text.trim().isNotEmpty &&
        (_selectedType != null ||
            _isCustomType && _customTypeController.text.trim().isNotEmpty) &&
        _selectedDifficulty != null &&
        _selectedPeriod != null;
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
                        BuildImage(
                          onImageSelected: (File? image) {
                            setState(() {});
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
                          itemCount: _programTypesProvider.programTypes.length,
                          itemBuilder: (context, index) {
                            final type =
                                _programTypesProvider.programTypes[index];
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
                                  gradient: isSelected
                                      ? LinearGradient(
                                          colors: [
                                            type['color1'].withOpacity(0.6),
                                            type['color1'].withOpacity(0.9),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(12),

                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.transparent
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
                          'Create custom type:',
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

                        // Difficulty Level Section
                        _buildDifficultySection(),

                        const SizedBox(height: 32),

                        // Program Duration Section
                        _buildPeriodSection(),

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
                  text: 'Continue',
                  color: _isFormValid()
                      ? AppColors.primaryColor
                      : Colors.grey[600]!,
                  icon: Icons.arrow_forward,
                  textColor: Colors.black,
                  onPressed: _isFormValid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
