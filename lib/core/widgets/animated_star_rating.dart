import 'package:flutter/material.dart';

class AnimatedStarRating extends StatefulWidget {
  final int rating;
  final int maxRating;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Function(int)? onRatingChanged;

  const AnimatedStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.size = 24.0,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.onRatingChanged,
  });

  @override
  State<AnimatedStarRating> createState() => _AnimatedStarRatingState();
}

class _AnimatedStarRatingState extends State<AnimatedStarRating>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.maxRating,
      (index) => AnimationController(
        duration: Duration(milliseconds: 200 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.0, end: 1.3),
          weight: 40,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.3, end: 1.0),
          weight: 60,
        ),
      ]).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
      ));
    }).toList();

    // Animate stars up to current rating
    _animateStars();
  }

  @override
  void didUpdateWidget(AnimatedStarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _animateStars();
    }
  }

  void _animateStars() {
    for (int i = 0; i < widget.maxRating; i++) {
      if (i < widget.rating) {
        _controllers[i].forward(from: 0.0);
      } else {
        _controllers[i].reverse(from: 1.0);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return GestureDetector(
          onTap: () {
            if (widget.onRatingChanged != null) {
              widget.onRatingChanged!(index + 1);
            }
          },
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.scale(
                scale: index < widget.rating ? _animations[index].value : 1.0,
                child: Icon(
                  index < widget.rating ? Icons.star : Icons.star_border,
                  color: index < widget.rating
                      ? widget.activeColor
                      : widget.inactiveColor,
                  size: widget.size,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
