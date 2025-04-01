import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/domain/entites/cart_item_entity.dart';
import 'package:fruits_hub/features/home/presentation/views/widgets/cart_item.dart';

class CartItemList extends StatelessWidget {
  static const _maxAnimationDelay = 500;
  static const _delayIncrement = 100;
  static const _itemPadding =
      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);

  final List<CartItemEntity> cartItems;

  const CartItemList({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final delay = _calculateStaggeredDelay(index);
          return _buildAnimatedCartItem(cartItems[index], delay);
        },
        childCount: cartItems.length,
      ),
    );
  }

  int _calculateStaggeredDelay(int index) {
    return (index * _delayIncrement).clamp(0, _maxAnimationDelay);
  }

  Widget _buildAnimatedCartItem(CartItemEntity item, int delay) {
    return AnimatedItemBuilder(
      key: ObjectKey(item),
      delay: Duration(milliseconds: delay),
      child: Padding(
        padding: _itemPadding,
        child: CartItem(cartItemEntity: item),
      ),
    );
  }
}

class AnimatedItemBuilder extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedItemBuilder({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedItemBuilder> createState() => _AnimatedItemBuilderState();
}

class _AnimatedItemBuilderState extends State<AnimatedItemBuilder>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 400);

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Delayed animation start
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  static const _dividerHeight = 20.0;
  static const _dividerThickness = 2.0;
  static const _animationDuration = Duration(milliseconds: 400);

  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: _animationDuration,
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Divider(
            height: _dividerHeight,
            color: const Color(0xFFF1F1F5).withOpacity(value),
            thickness: _dividerThickness * value,
          ),
        );
      },
    );
  }
}
