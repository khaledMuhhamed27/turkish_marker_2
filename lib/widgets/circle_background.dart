import 'package:flutter/material.dart';

class CircleBackgroundPainter extends CustomPainter {
  final Color circleColor;
  CircleBackgroundPainter({required this.circleColor});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = circleColor // لون الدوائر
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final double centerX = size.width / 2;
    final double centerY = size.height * 0.2; // تحديد مركز الدوائر العلوية

    // أحجام الدوائر
    List<double> circleRadii = [80, 140, 200, 260];

    for (double radius in circleRadii) {
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
