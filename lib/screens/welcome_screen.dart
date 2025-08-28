import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/providers/language.dart';
import 'package:gym/widgets/costum_button.dart';
import '../core/fonts.dart';
import '../core/lang/english.dart';
import '../core/lang/french.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  final eng = English();
  final fr = French();

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize animations
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations with delays
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _fadeController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();

    await Future.delayed(const Duration(milliseconds: 600));
    _scaleController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/second_image.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Animated title
                        AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                20 * (1 - _fadeAnimation.value),
                              ),
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: Text(
                                  provider.locale.languageCode == 'fr'
                                      ? fr.welcomeTitle
                                      : eng.welcomeTitle,
                                  style: Fonts.title.copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Animated highlight container
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  provider.locale.languageCode == 'fr'
                                      ? fr.doItNow
                                      : eng.doItNow,
                                  style: Fonts.title.copyWith(
                                    fontSize:
                                        provider.locale.languageCode == 'fr'
                                        ? 20
                                        : 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Animated description text
                        AnimatedBuilder(
                          animation: _fadeAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                30 * (1 - _fadeAnimation.value),
                              ),
                              child: Opacity(
                                opacity: _fadeAnimation.value,
                                child: Text(
                                  provider.locale.languageCode == 'fr'
                                      ? fr.welcomeText
                                      : eng.welcomeText,
                                  style: Fonts.text.copyWith(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // Animated button
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: CustomButton(
                                text: provider.locale.languageCode == 'fr'
                                    ? fr.welcomeButton
                                    : eng.welcomeButton,
                                color: AppColors.primaryColor,
                                textColor: Colors.black,
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
