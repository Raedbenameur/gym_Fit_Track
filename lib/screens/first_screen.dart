import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language.dart';
import '../core/colors.dart';
import '../core/fonts.dart';
import '../core/lang/english.dart';
import '../core/lang/french.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  final eng = English();
  final fr = French();

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/second_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          44,
                          43,
                          43,
                          1,
                        ).withOpacity(0.95),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.language_rounded,
                              size: 48,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            provider.locale.languageCode == 'fr'
                                ? fr.language
                                : eng.language,
                            style: Fonts.title.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                await provider.changeLanguage('en');
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/welcome',
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryDark,
                                elevation: 2,
                                shadowColor: AppColors.primaryDark.withOpacity(
                                  0.3,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'English',
                                style: Fonts.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                await provider.changeLanguage('fr');
                                if (context.mounted) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/welcome',
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primaryDark,
                                elevation: 0,
                                side: BorderSide(
                                  color: AppColors.primaryDark,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Français',
                                style: Fonts.title.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
