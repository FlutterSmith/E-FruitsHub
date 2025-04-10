import 'package:flutter/material.dart';

mixin SearchAnimationMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<Offset> _slideAnimation;

  void initializeAnimations(
    TickerProvider vsync, {
    Color startColor = const Color(0xFF949D9E),
    Color endColor = const Color(0xFF53B175),
    Duration duration = const Duration(milliseconds: 200),
  }) {
    _animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.03), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.03, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: startColor,
      end: endColor,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  void disposeAnimations() {
    _animationController.dispose();
  }

  void forwardAnimation() {
    _animationController.forward();
  }

  void reverseAnimation() {
    _animationController.reverse();
  }

  void pulseAnimation() {
    _animationController.forward().then((_) => _animationController.reverse());
  }

  AnimationController get animationController => _animationController;
  Animation<double> get scaleAnimation => _scaleAnimation;
  Animation<double> get opacityAnimation => _opacityAnimation;
  Animation<Color?> get colorAnimation => _colorAnimation;
  Animation<Offset> get slideAnimation => _slideAnimation;
}
