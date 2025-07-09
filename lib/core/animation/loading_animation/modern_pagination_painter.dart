import 'package:flutter/material.dart';
import 'dart:math' as math;

class ModernPaginationPainter extends CustomPainter {
  final Color color;
  final double progress;

  ModernPaginationPainter({required this.color, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer ring
    final outerPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(center, radius * 0.9, outerPaint);

    // Draw animated arcs
    for (int i = 0; i < 3; i++) {
      final animationOffset = (progress + i * 0.33) % 1.0;
      final startAngle = animationOffset * 2 * 3.14159;
      final sweepAngle = 0.8 * 3.14159;

      final arcRadius = radius * (0.9 - i * 0.15);
      final strokeWidth = 3.0 - i * 0.8;
      final opacity = 0.9 - i * 0.3;

      final arcPaint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: arcRadius),
        startAngle,
        sweepAngle,
        false,
        arcPaint,
      );
    }

    // Draw center dots
    final dotRadius = radius * 0.15;
    for (int i = 0; i < 3; i++) {
      final angle = (progress * 2 * 3.14159) + (i * 2 * 3.14159 / 3);
      final dotOffset = Offset(
        center.dx + (radius * 0.3) * math.cos(angle),
        center.dy + (radius * 0.3) * math.sin(angle),
      );

      final dotPaint = Paint()
        ..color = color.withOpacity(0.8 - i * 0.2)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(dotOffset, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
