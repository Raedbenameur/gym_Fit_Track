import 'package:flutter/material.dart';
import 'package:gym/screens/first_screen.dart';

import 'package:gym/screens/welcome_screen.dart';
import '../screens/layout_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const Language(),
    '/welcome': (context) => WelcomeScreen(),
    '/home': (context) => const LayoutScreen(),
  };

  // Generic slide animation method
  static Future<T?> slideFromRight<T extends Object?>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push<T>(
      context,
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 250),
      ),
    );
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  FadePageRoute({required this.child})
    : super(
        transitionDuration: const Duration(milliseconds: 400),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => child,
      );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    var curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return FadeTransition(opacity: curvedAnimation, child: child);
  }
}

Future<T?> fadeToPage<T>(BuildContext context, Widget page) {
  return Navigator.push<T>(context, FadePageRoute<T>(child: page));
}
