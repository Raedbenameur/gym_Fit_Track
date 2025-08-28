import 'package:flutter/material.dart';
import 'package:gym/screens/first_screen.dart';
import 'package:gym/screens/welcome_screen.dart';
import '../screens/layout_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const Language(),
    '/welcome': (context) => WelcomeScreen(),
    '/home': (conext) => const LayoutScreen(),
  };
}
