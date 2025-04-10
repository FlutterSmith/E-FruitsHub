import 'package:svg_flutter/svg_flutter.dart';
import 'dart:async';

import '../../constants.dart';
import '../../exports.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onFilterTap,
    this.debounceTime = const Duration(milliseconds: 500),
    this.showAnimation = true,
    this.accentColor = const Color(0xFF53B175),
  });

  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onFilterTap;
  final Duration debounceTime;
  final bool showAnimation;
  final Color accentColor;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  bool _hasText = false;
  bool _isFocused = false;
  Timer? _debounce;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_updateHasText);

    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _animationController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();

    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_updateHasText);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (widget.showAnimation) {
      if (_focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  void _updateHasText() {
    final hasText = _controller.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(widget.debounceTime, () {
      // Only trigger search when there's actual text
      if (value.isNotEmpty) {
        widget.onChanged?.call(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kTopPadding),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: widget.showAnimation ? _scaleAnimation.value : 1.0,
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Increased radius
                ),
                shadows: [
                  BoxShadow(
                    color: _isFocused
                        ? widget.accentColor.withOpacity(0.15)
                        : const Color(0x0A000000),
                    blurRadius: _isFocused ? 12 : 9,
                    offset: const Offset(0, 2),
                    spreadRadius: _isFocused ? 1 : 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.text,
                  onChanged: _onSearchChanged,
                  onSubmitted: widget.onSubmitted,
                  decoration: InputDecoration(
                    prefixIcon: AnimatedOpacity(
                      opacity: _hasText ? 0.7 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        width: 20,
                        child: Center(
                          child: SvgPicture.asset(
                            Assets.assetsImagesSearchNormal,
                            color: _isFocused
                                ? widget.accentColor
                                : const Color(0xFF949D9E),
                          ),
                        ),
                      ),
                    ),
                    hintText: widget.hintText,
                    hintStyle: TextStyles.regular16.copyWith(
                      color: const Color(0xFF949D9E),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: kTopPadding, vertical: 18),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: widget.accentColor.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_hasText)
                          AnimatedOpacity(
                            opacity: _opacityAnimation.value,
                            duration: const Duration(milliseconds: 200),
                            child: GestureDetector(
                              onTap: _clearSearch,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEEEEE),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Color(0xFF616161),
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: widget.onFilterTap,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _isFocused
                                  ? widget.accentColor.withOpacity(0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: 20,
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.assetsImagesSetting,
                                  color: _isFocused ? widget.accentColor : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
