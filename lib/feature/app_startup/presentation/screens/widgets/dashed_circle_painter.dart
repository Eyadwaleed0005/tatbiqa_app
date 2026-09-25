
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tatbiqa/core/style/app_color.dart';

class DashedCirclePainter extends CustomPainter {
  final double animationValue;

  DashedCirclePainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    _drawDashedArc(
      canvas,
      center,
      radius * 0.55,
       ColorPalette.primary.withValues(alpha: 0.9),
      1.6,
      animationValue * 2 * math.pi * 1.5,
      dashLength: 7.0,
      dashSpace: 7.0,
    );

    _drawDashedArc(
      canvas,
      center,
      radius * 0.72,
      ColorPalette.purple.withValues(alpha: 0.5),
      1.8,
      -animationValue * 2 * math.pi * 1.2,
      dashLength: 10.0,
      dashSpace: 9.0,
    );

    _drawDashedArc(
      canvas,
      center,
      radius * 0.90,
        ColorPalette.primary.withValues(alpha: 0.15),
      1.2,
      animationValue * 2 * math.pi,
      dashLength: 10.0,
      dashSpace: 11.0,
    );
  }

  void _drawDashedArc(
    Canvas canvas,
    Offset center,
    double radius,
    Color color,
    double strokeWidth,
    double startAngle, {
    required double dashLength,
    required double dashSpace,
  }) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var currentAngle = startAngle;
    final circumference = 2 * math.pi * radius;
    final dashAngle = (dashLength / circumference) * 2 * math.pi;
    final spaceAngle = (dashSpace / circumference) * 2 * math.pi;

    while (currentAngle < startAngle + 2 * math.pi) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        dashAngle,
        false,
        paint,
      );
      currentAngle += dashAngle + spaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
