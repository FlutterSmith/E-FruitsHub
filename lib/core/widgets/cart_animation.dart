import 'package:flutter/material.dart';

class CartItemAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onAddToCart;

  const CartItemAnimation({
    super.key,
    required this.child,
    required this.onAddToCart,
  });

  @override
  State<CartItemAnimation> createState() => _CartItemAnimationState();
}

class _CartItemAnimationState extends State<CartItemAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.2),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 0.8),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.8, end: 1.0),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 0.05),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.05, end: -0.05),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.05, end: 0),
        weight: 30,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playAnimation() {
    _controller.reset();
    _controller.forward().then((_) {
      widget.onAddToCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _playAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotateAnimation.value,
              child: widget.child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class CartAddedOverlay extends StatefulWidget {
  final Widget child;

  const CartAddedOverlay({
    super.key,
    required this.child,
  });

  @override
  State<CartAddedOverlay> createState() => _CartAddedOverlayState();
}

class _CartAddedOverlayState extends State<CartAddedOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.7),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.7, end: 0.7),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.7, end: 0.0),
        weight: 20,
      ),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showAddedToCartIndicator() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
