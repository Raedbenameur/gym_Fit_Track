import 'package:flutter/material.dart';
import 'package:gym/core/fonts.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onClear;
  final IconData? prefixIcon;
  final bool enabled;

  const SearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.onClear,
    this.prefixIcon = Icons.search,
    this.enabled = true,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        style: Fonts.text.copyWith(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Fonts.text.copyWith(color: Colors.grey[500]),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Colors.grey[500],
            size: 18,
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500], size: 18),
                  onPressed: () {
                    widget.controller.clear();
                    if (widget.onChanged != null) {
                      widget.onChanged!('');
                    }
                    if (widget.onClear != null) {
                      widget.onClear!();
                    }
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
          setState(() {}); // Update UI to show/hide clear button
        },
      ),
    );
  }
}
