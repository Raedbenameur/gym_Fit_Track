import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

class StatItem extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;
  final Duration delay;
  final bool isFireIcon; // Add this parameter

  const StatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.delay = Duration.zero,
    this.isFireIcon = false, // Default to false
  });

  @override
  State<StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<StatItem> with TickerProviderStateMixin {
  // Changed to TickerProviderStateMixin
  late AnimationController _animationController;
  late AnimationController
  _fireAnimationController; // Add fire animation controller
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fireScaleAnimation; // Fire scale animation

  late Animation<Color?> _fireColorAnimation; // Fire color animation

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Fire animation controller
    _fireAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
          ),
        );

    // Fire animations
    _fireScaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(
        parent: _fireAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _fireColorAnimation = ColorTween(begin: Colors.orange, end: Colors.red)
        .animate(
          CurvedAnimation(
            parent: _fireAnimationController,
            curve: Curves.easeInOut,
          ),
        );

    // Start animation with delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _animationController.forward();
        // Start fire animation if it's a fire icon
        if (widget.isFireIcon) {
          _startFireAnimation();
        }
      }
    });
  }

  void _startFireAnimation() {
    _fireAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fireAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,

              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Animated Icon with Fire Effect
                    widget.isFireIcon
                        ? _buildFireIcon()
                        : Icon(
                            widget.icon,
                            color: AppColors.primaryColor,
                            size: 28,
                          ),
                    const SizedBox(height: 12),

                    // Animated Value with Counter Effect
                    TweenAnimationBuilder<double>(
                      duration: Duration(
                        milliseconds: 1000 + widget.delay.inMilliseconds,
                      ),
                      tween: Tween<double>(
                        begin: 0,
                        end:
                            double.tryParse(
                              widget.value.replaceAll(RegExp(r'[^0-9.]'), ''),
                            ) ??
                            0,
                      ),
                      builder: (context, value, child) {
                        // If value contains non-numeric characters, show original
                        if (widget.value.contains(RegExp(r'[^0-9.]'))) {
                          return Text(
                            widget.value,
                            style: Fonts.title.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }

                        return Text(
                          value.toInt().toString(),
                          style: Fonts.title.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),

                    // Animated Label
                    Text(
                      widget.label,
                      style: Fonts.text.copyWith(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFireIcon() {
    return AnimatedBuilder(
      animation: _fireAnimationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: 0,
          child: Transform.scale(
            scale: _fireScaleAnimation.value,

            child: Stack(
              alignment: Alignment.center,

              children: [
                // Fire icon
                Icon(
                  widget.icon,
                  color:
                      _fireColorAnimation.value ??
                      const Color.fromARGB(255, 255, 0, 0),
                  size: 28,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
