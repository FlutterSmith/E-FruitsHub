import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedLoadingIndicator extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final double size;

  const AnimatedLoadingIndicator({
    super.key,
    this.primaryColor = Colors.green,
    this.secondaryColor = Colors.orange,
    this.size = 60.0,
  });

  @override
  State<AnimatedLoadingIndicator> createState() =>
      _AnimatedLoadingIndicatorState();
}

class _AnimatedLoadingIndicatorState extends State<AnimatedLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _radiusAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _radiusAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _colorAnimation = ColorTween(
      begin: widget.primaryColor,
      end: widget.secondaryColor,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LoadingPainter(
              rotationValue: _rotationAnimation.value,
              radius: _radiusAnimation.value,
              color: _colorAnimation.value ?? widget.primaryColor,
            ),
          );
        },
      ),
    );
  }
}

class _LoadingPainter extends CustomPainter {
  final double rotationValue;
  final double radius;
  final Color color;

  _LoadingPainter({
    required this.rotationValue,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final double circleRadius = size.width / 6;
    final double orbitRadius = size.width / 3;

    for (int i = 0; i < 3; i++) {
      final angle = (rotationValue * 2 * 3.14) + (i * (2 * 3.14 / 3));
      final x = center.dx + orbitRadius * cos(angle);
      final y = center.dy + orbitRadius * sin(angle);
      final circleSize = circleRadius - (i * 2);

      canvas.drawCircle(
        Offset(x, y),
        circleSize + (i == 0 ? radius : 0),
        paint..color = color.withOpacity(1 - (i * 0.2)),
      );
    }
  }

  @override
  bool shouldRepaint(_LoadingPainter oldDelegate) {
    return oldDelegate.rotationValue != rotationValue ||
        oldDelegate.radius != radius ||
        oldDelegate.color != color;
  }
}
