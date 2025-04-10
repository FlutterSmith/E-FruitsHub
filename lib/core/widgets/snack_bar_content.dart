import 'package:flutter/material.dart';

class SnackBarContent extends StatelessWidget {
  final String message;
  final TextStyle? textStyle;
  final Icon? leadingIcon;

  const SnackBarContent({
    super.key,
    required this.message,
    this.textStyle,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            message,
            style: textStyle ?? const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
