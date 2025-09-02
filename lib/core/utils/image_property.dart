import 'package:flutter/material.dart ';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

class ImageProperty {
  static final List<Map<String, dynamic>> _fitOptions = [
    {
      'fit': BoxFit.cover,
      'name': 'Cover',
      'icon': Icons.fullscreen,
      'description': 'Fill container, may crop',
    },
    {
      'fit': BoxFit.contain,
      'name': 'Contain',
      'icon': Icons.fit_screen,
      'description': 'Fit entirely, may have gaps',
    },
    {
      'fit': BoxFit.fill,
      'name': 'Fill',
      'icon': Icons.aspect_ratio,
      'description': 'Stretch to fill, may distort',
    },
    {
      'fit': BoxFit.fitWidth,
      'name': 'Fit Width',
      'icon': Icons.width_full,
      'description': 'Fit width, may crop height',
    },
    {
      'fit': BoxFit.fitHeight,
      'name': 'Fit Height',
      'icon': Icons.height,
      'description': 'Fit height, may crop width',
    },
  ];

  static void showFitOptions(
    BuildContext context,
    BoxFit currentFit,
    Function(BoxFit) onFitSelected,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1D1D1D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Image Fit Options',
                style: Fonts.title.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),

              // Fit options list - Fixed: Removed ListView.builder and SingleChildScrollView inside
              ...List.generate(_fitOptions.length, (index) {
                final option = _fitOptions[index];
                final isSelected = currentFit == option['fit'];
                return GestureDetector(
                  onTap: () {
                    onFitSelected(option['fit']);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(0xFFFDDD48).withOpacity(0.2)
                          : const Color(0xFF2A2A2A),
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
                          option['icon'],
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[400],
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                option['name'],
                                style: Fonts.text.copyWith(
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                option['description'],
                                style: Fonts.text.copyWith(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: AppColors.primaryColor,
                            size: 20,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  static String getFitName(BoxFit fit) {
    final option = _fitOptions.firstWhere(
      (option) => option['fit'] == fit,
      orElse: () => _fitOptions.first,
    );
    return option['name'];
  }

  // Get all available fit options
  static List<Map<String, dynamic>> get fitOptions => _fitOptions;
}
