import 'package:flutter/material.dart';
import 'package:gym/core/fonts.dart';

class AppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  const AppBar({super.key, required this.title, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),

            child: Center(
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Fonts.title.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                Text(
                  subtitle,
                  style: Fonts.text.copyWith(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
