import 'package:flutter/material.dart';
import 'package:gym/core/colors.dart';
import 'package:gym/core/fonts.dart';

class CustomField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final int maxLines;
  final int? maxLength;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool required;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;

  const CustomField({
    super.key,
    required this.controller,
    this.labelText = '',
    required this.hintText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.required = false,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.contentPadding,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (widget.labelText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  widget.labelText,
                  style: Fonts.text.copyWith(
                    color: widget.focusedBorderColor ?? AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.required)
                  Text(
                    ' *',
                    style: Fonts.text.copyWith(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),

        // Text Field Container
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isFocused
                  ? (widget.focusedBorderColor ?? AppColors.primaryColor)
                  : (widget.borderColor ?? Colors.grey[700]!),
              width: _isFocused ? 1 : 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            style: Fonts.text.copyWith(
              color: widget.enabled ? Colors.white : Colors.grey[500],
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: Fonts.text.copyWith(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: _isFocused
                          ? (widget.focusedBorderColor ??
                                AppColors.primaryColor)
                          : Colors.grey[500],
                      size: 20,
                    )
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        color: _isFocused
                            ? (widget.focusedBorderColor ??
                                  AppColors.primaryColor)
                            : Colors.grey[500],
                        size: 20,
                      ),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  widget.contentPadding ??
                  EdgeInsets.all(widget.maxLines > 1 ? 16 : 16),
              counterStyle: Fonts.text.copyWith(
                color: Colors.grey[500],
                fontSize: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
