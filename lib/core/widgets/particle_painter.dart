import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class ParticlePainter extends CustomPainter {
  final List<DissolveParticle> particles;

  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      if (particle.opacity <= 0) continue;

      final paint = Paint()
        ..color = particle.color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(particle.x, particle.y);
      canvas.rotate(particle.rotation);

      switch (particle.shape) {
        case ParticleShape.circle:
          canvas.drawCircle(Offset.zero, particle.size, paint);
          break;
        case ParticleShape.square:
          canvas.drawRect(
              Rect.fromCenter(
                  center: Offset.zero,
                  width: particle.size * 2,
                  height: particle.size * 2),
              paint);
          break;
        case ParticleShape.triangle:
          final path = Path();
          final side = particle.size * 2;
          path.moveTo(0, -side / 2);
          path.lineTo(side / 2, side / 2);
          path.lineTo(-side / 2, side / 2);
          path.close();
          canvas.drawPath(path, paint);
          break;
      }

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) => true;
}

class DissolveParticle {
  double x;
  double y;
  final Color color;
  final double size;
  double speedX;
  double speedY;
  double opacity;
  double rotation;
  final ParticleShape shape;

  DissolveParticle({
    required this.x,
    required this.y,
    required this.color,
    required this.size,
    required this.speedX,
    required this.speedY,
    this.opacity = 1.0,
    this.rotation = 0.0,
    this.shape = ParticleShape.circle,
  });

  void update() {
    x += speedX;
    y += speedY;
    speedY += 0.15; // Add gravity
    opacity -= 0.015; // Slower fade
    rotation += 0.05; // Update rotation
  }
}

enum ParticleShape { circle, square, triangle }
