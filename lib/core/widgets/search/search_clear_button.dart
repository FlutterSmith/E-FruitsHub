import 'package:flutter/material.dart';

class SearchClearButton extends StatelessWidget {
  const SearchClearButton({
    super.key,
    required this.onTap,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.iconColor = const Color(0xFF616161),
    this.iconSize = 16,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.close,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
