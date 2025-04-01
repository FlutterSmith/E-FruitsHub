import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:svg_flutter/svg_flutter.dart';


class SearchFilterButton extends StatelessWidget {
  const SearchFilterButton({
    super.key,
    required this.onTap,
    required this.isFocused,
    this.accentColor = const Color(0xFF53B175),
  });

  final VoidCallback? onTap;
  final bool isFocused;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isFocused ? accentColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 20,
          child: Center(
            child: SvgPicture.asset(
              Assets.assetsImagesSetting,
              color: isFocused ? accentColor : null,
            ),
          ),
        ),
      ),
    );
  }
}
