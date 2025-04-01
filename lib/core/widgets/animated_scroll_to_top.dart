import 'package:flutter/material.dart';

class AnimatedScrollToTop extends StatefulWidget {
  final ScrollController scrollController;
  final Widget child;
  final Color buttonColor;
  final Color iconColor;
  final double buttonSize;
  final double scrollThreshold;

  const AnimatedScrollToTop({
    super.key,
    required this.scrollController,
    required this.child,
    this.buttonColor = Colors.green,
    this.iconColor = Colors.white,
    this.buttonSize = 50.0,
    this.scrollThreshold = 300.0,
  });

  @override
  State<AnimatedScrollToTop> createState() => _AnimatedScrollToTopState();
}

class _AnimatedScrollToTopState extends State<AnimatedScrollToTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.scrollController.offset >= widget.scrollThreshold) {
      if (!_showButton) {
        setState(() {
          _showButton = true;
          _controller.forward();
        });
      }
    } else {
      if (_showButton) {
        setState(() {
          _showButton = false;
          _controller.reverse();
        });
      }
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          right: 20,
          bottom: 30,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: GestureDetector(
                  onTap: _scrollToTop,
                  child: AnimatedOpacity(
                    opacity: _showButton ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: widget.buttonSize,
                      height: widget.buttonSize,
                      decoration: BoxDecoration(
                        color: widget.buttonColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.buttonColor.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_upward,
                        color: widget.iconColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
