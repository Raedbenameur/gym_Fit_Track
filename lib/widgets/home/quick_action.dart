import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

class QuickAction extends StatefulWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  final bool isStartWorkout; // Add this parameter

  const QuickAction({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isStartWorkout = false, // Default to false
  });

  @override
  State<QuickAction> createState() => _QuickActionState();
}

class _QuickActionState extends State<QuickAction>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _borderColorAnimation;

  @override
  void initState() {
    super.initState();

    if (widget.isStartWorkout) {
      _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this,
      );

      _borderColorAnimation =
          ColorTween(
            begin: AppColors.primaryColor.withOpacity(0.3),
            end: AppColors.primaryColor.withOpacity(0.8),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          );

      // Start the animation
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    if (widget.isStartWorkout) {
      _animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: widget.isStartWorkout
          ? AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          _borderColorAnimation.value ??
                          AppColors.primaryColor.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            (_borderColorAnimation.value ??
                                    AppColors.primaryColor)
                                .withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        widget.icon,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.title,
                        style: Fonts.text.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            )
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(widget.icon, color: AppColors.primaryColor, size: 24),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    style: Fonts.text.copyWith(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
