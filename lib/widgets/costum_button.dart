import 'package:flutter/material.dart';
import '../core/fonts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final IconData? icon;
  final Color? borderColor; // Add border color
  final double? borderWidth; // Add border width

  const CustomButton({
    super.key,
    required this.textColor,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.icon,
    this.borderColor, // Add this parameter
    this.borderWidth, // Add this parameter
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: widget.width ?? double.infinity,

              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: widget.height ?? 16,
              ),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(16),
                border: widget.borderColor != null
                    ? Border.all(
                        color: widget.borderColor!,
                        width: widget.borderWidth ?? 1.0,
                      )
                    : null, // Add border support
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: widget.textColor,
                      size: widget.fontSize ?? 18,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: Fonts.title.copyWith(
                      color: widget.textColor,
                      fontSize: widget.fontSize ?? 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
