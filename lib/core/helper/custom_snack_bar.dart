import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  info,
  warning,
}

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onVisible,
    bool dismissible = true,
  }) {
    // Clear any existing snack bars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Define styling based on type
    Color backgroundColor;
    Color textColor = Colors.white;
    IconData iconData;

    switch (type) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case SnackBarType.error:
        backgroundColor = Colors.redAccent;
        iconData = Icons.error_outline;
        break;
      case SnackBarType.warning:
        backgroundColor = Colors.amber;
        textColor = Colors.black87;
        iconData = Icons.warning_amber;
        break;
      case SnackBarType.info:
      default:
        backgroundColor = Colors.blue;
        iconData = Icons.info_outline;
        break;
    }

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(iconData, color: textColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      action: action,
      onVisible: onVisible,
      dismissDirection:
          dismissible ? DismissDirection.horizontal : DismissDirection.none,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
