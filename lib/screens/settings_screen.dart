import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../core/fonts.dart';
import '../providers/language.dart';
import '../core/lang/english.dart';
import '../core/lang/french.dart';
import 'package:gym/widgets/app_bar.dart' as custom_app_bar;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  final eng = English();
  final fr = French();
  final int date = DateTime.now().year;
  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Language',
                          style: Fonts.title.copyWith(
                            color: Colors.white,
                            fontSize: 20,
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
                    const SizedBox(height: 20),
                    _buildLanguageOption(
                      'English',
                      'en',
                      languageProvider.locale.languageCode == 'en',
                      languageProvider,
                    ),
                    const SizedBox(height: 12),
                    _buildLanguageOption(
                      'Français',
                      'fr',
                      languageProvider.locale.languageCode == 'fr',
                      languageProvider,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption(
    String language,
    String code,
    bool isSelected,
    LanguageProvider provider,
  ) {
    return GestureDetector(
      onTap: () {
        provider.changeLanguage(code);
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withValues(alpha: 0.2)
              : const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.language,
              color: isSelected ? AppColors.primaryColor : Colors.grey[400],
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              language,
              style: Fonts.text.copyWith(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primaryColor, size: 20),
          ],
        ),
      ),
    );
  }

  void _showContactDialog() {
    final TextEditingController messageController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Text(
                    'Contact & Feedback',
                    style: Fonts.title.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    'We\'d love to hear from you! Send us your feedback or questions.',
                    style: Fonts.text.copyWith(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Email TextField
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!, width: 1),
                    ),
                    child: TextField(
                      controller: emailController,
                      style: Fonts.text.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Your email address',
                        hintStyle: Fonts.text.copyWith(color: Colors.grey[500]),
                        prefixIcon: Icon(Icons.email, color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Message TextField
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF3A3A3A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!, width: 1),
                    ),
                    child: TextField(
                      controller: messageController,
                      style: Fonts.text.copyWith(color: Colors.white),
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Your message or feedback...',
                        hintStyle: Fonts.text.copyWith(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            messageController.clear();
                            emailController.clear();

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate inputs
                            if (emailController.text.trim().isEmpty) {
                              _showErrorSnackBar('Please enter your email');
                              return;
                            }
                            if (messageController.text.trim().isEmpty) {
                              _showErrorSnackBar('Please enter your message');
                              return;
                            }

                            // Process the feedback
                            _sendFeedback(
                              emailController.text.trim(),
                              messageController.text.trim(),
                            );

                            messageController.clear();
                            emailController.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Add these helper methods:
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendFeedback(String email, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Thank you for your feedback! We\'ll get back to you soon.',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 29, 28, 28),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Back Arrow
                  custom_app_bar.AppBar(
                    title: languageProvider.locale.languageCode == 'fr'
                        ? 'Paramètres'
                        : 'Settings',
                  ),
                  const SizedBox(height: 32),

                  // Settings Options
                  _buildSettingsSection(
                    languageProvider.locale.languageCode == 'fr'
                        ? 'Général'
                        : 'General',
                    [
                      _buildSettingsItem(
                        icon: Icons.language,
                        title: languageProvider.locale.languageCode == 'fr'
                            ? 'Langue'
                            : 'Language',
                        subtitle: languageProvider.locale.languageCode == 'fr'
                            ? 'Français'
                            : 'English',
                        onTap: _showLanguageDialog,
                      ),
                      _buildSettingsItem(
                        icon: Icons.notifications,
                        title: languageProvider.locale.languageCode == 'fr'
                            ? 'Notifications'
                            : 'Notifications',
                        subtitle: notificationsEnabled
                            ? (languageProvider.locale.languageCode == 'fr'
                                  ? 'Activées'
                                  : 'Enabled')
                            : (languageProvider.locale.languageCode == 'fr'
                                  ? 'Désactivées'
                                  : 'Disabled'),
                        trailing: Switch(
                          value: notificationsEnabled,
                          activeThumbColor: AppColors.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              notificationsEnabled = value;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            notificationsEnabled = !notificationsEnabled;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  _buildSettingsSection(
                    languageProvider.locale.languageCode == 'fr'
                        ? 'À propos'
                        : 'About',
                    [],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header

                      // App Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // App Name
                      Text(
                        'Gym Tracker',
                        style: Fonts.title.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Version
                      Text(
                        'Version 1.0.0',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // copyright
                      Text(
                        '© $date Gym Tracker. All rights reserved.',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Made with ❤️ by Mo Raed ',
                        style: Fonts.text.copyWith(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Contact Button
                      GestureDetector(
                        onTap: () {
                          // Open email or contact form

                          _showContactDialog();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: AppColors.primaryColor,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Contact & Feedback',
                                style: Fonts.text.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Fonts.title.copyWith(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),

        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 18),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Fonts.text.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Fonts.text.copyWith(
                      color: Colors.grey[400],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
          ],
        ),
      ),
    );
  }
}
