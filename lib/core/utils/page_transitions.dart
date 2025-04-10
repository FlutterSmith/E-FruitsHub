import 'package:flutter/material.dart';

class FadePageTransition extends PageRouteBuilder {
  final Widget page;
  FadePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.0;
            var end = 1.0;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        );
}

class SlidePageTransition extends PageRouteBuilder {
  final Widget page;
  final SlideDirection direction;

  SlidePageTransition(
      {required this.page, this.direction = SlideDirection.right})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = direction == SlideDirection.right
                ? const Offset(1.0, 0.0)
                : direction == SlideDirection.left
                    ? const Offset(-1.0, 0.0)
                    : direction == SlideDirection.up
                        ? const Offset(0.0, -1.0)
                        : const Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
}

class ScalePageTransition extends PageRouteBuilder {
  final Widget page;

  ScalePageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = 0.8;
            var end = 1.0;
            var curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return ScaleTransition(
              scale: animation.drive(tween),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
}

enum SlideDirection { right, left, up, down }
