import 'package:fruits_hub/exports.dart';

class CustomSwitchButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;

  const CustomSwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFF1B5E37),
    this.inactiveColor = const Color(0xFFE0E0E0),
    this.thumbColor = Colors.white,
  });

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 200);
  static const _switchWidth = 28.57 * 1.5;
  static const _switchHeight = 16.0 * 1.5;
  static const _thumbSize = 16.0 * 1.5;
  static const _thumbBorderWidth = 1.50 * 1.5;
  static const _maxThumbPosition = 12.57 * 1.5; // How far the thumb can move
  static const _switchBorderRadius = 16.0 * 2.0;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Set initial animation value based on widget.value
    _animationController.value = widget.value ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(CustomSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) => _buildSwitchBody(),
      ),
    );
  }

  Widget _buildSwitchBody() {
    return Container(
      width: _switchWidth,
      height: _switchHeight,
      decoration: BoxDecoration(
        color: widget.value ? widget.activeColor : widget.inactiveColor,
        borderRadius:
            const BorderRadius.all(Radius.circular(_switchBorderRadius)),
      ),
      child: _buildThumb(),
    );
  }

  Widget _buildThumb() {
    return Stack(
      children: [
        Positioned(
          left: _animation.value * _maxThumbPosition,
          top: 0,
          child: Container(
            width: _thumbSize,
            height: _thumbSize,
            decoration: ShapeDecoration(
              color: widget.thumbColor,
              shape: OvalBorder(
                side: BorderSide(
                  width: _thumbBorderWidth,
                  color:
                      widget.value ? widget.activeColor : widget.inactiveColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
