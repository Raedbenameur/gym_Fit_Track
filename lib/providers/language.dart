import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = _getSystemLocale();
  late bool isFirstTime;
  Locale get locale => _locale;

  static Locale _getSystemLocale() {
    final systemLocale = ui.window.locale.languageCode;

    return systemLocale == 'fr' ? const Locale('fr') : const Locale('en');
  }

  Future<void> changeLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);

    _locale = Locale(langCode);
    isFirstTime = false;
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLangCode = prefs.getString('language_code');

    if (savedLangCode != null) {
      // User has previously selected a language
      _locale = Locale(savedLangCode);
      isFirstTime = false;
    } else {
      // First time user - use system language

      _locale = _getSystemLocale();
      isFirstTime = true;
    }
    notifyListeners();
  }
}
