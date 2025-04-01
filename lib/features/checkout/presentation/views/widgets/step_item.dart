import 'package:flutter/material.dart';

class StepItem extends StatelessWidget {
  static const _activeColor = Color(0xFF1B5E37);
  static const _inactiveColor = Color(0xFFD3D5D5);
  static const _textActiveColor = Color(0xFF1B5E37);
  static const _textInactiveColor = Color(0xFF4E5556);
  static const _indicatorSize = 32.0;
  static const _textFontSize = 11.0;
  static const _indexFontSize = 14.0;
  static const _verticalSpacing = 5.0;
  static const _lineHeight = 1.5;
  static const _animationDuration = Duration(milliseconds: 250);

  final String text;
  final String index;
  final bool isActive;

  const StepItem({
    super.key,
    required this.text,
    required this.index,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      child: Column(
        key: ValueKey('step-$index-$isActive'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicator(),
          const SizedBox(height: _verticalSpacing),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return AnimatedContainer(
      duration: _animationDuration,
      height: _indicatorSize,
      width: _indicatorSize,
      decoration: BoxDecoration(
        color: isActive ? _activeColor : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? _activeColor : _inactiveColor,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          index,
          style: TextStyle(
            color: isActive ? Colors.white : _textInactiveColor,
            fontSize: _indexFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isActive ? _textActiveColor : _textInactiveColor,
        fontSize: _textFontSize,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        height: _lineHeight,
      ),
    );
  }
}
