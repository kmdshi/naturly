// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class AnimantedRingWidget extends StatefulWidget {
  final int goal;
  final int eaten;
  final Color completedColor;
  final double size;
  final bool isNeedDonut;
  final double strokeWidth;
  final Widget? centerData;
  const AnimantedRingWidget({
    super.key,
    required this.goal,
    required this.eaten,
    required this.completedColor,
    required this.strokeWidth,
    this.centerData,

    this.isNeedDonut = false,
    this.size = 100,
  });

  @override
  _AnimantedRingWidgetState createState() => _AnimantedRingWidgetState();
}

class _AnimantedRingWidgetState extends State<AnimantedRingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    final progress = (widget.eaten / widget.goal).clamp(0.0, 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _RingPainter(
                  progress: _animation.value,
                  completedColor: widget.completedColor,
                  isNeedDonut: widget.isNeedDonut,
                  strokeWidth: widget.strokeWidth,
                ),
              );
            },
          ),
          if (widget.centerData != null) widget.centerData!,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color completedColor;
  final bool isNeedDonut;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.completedColor,
    required this.isNeedDonut,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = size.width / 2 - 10;

    final Paint bgPaint =
        Paint()
          ..color = Color(0xFFF0F0F0)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final Paint fgPaint =
        Paint()
          ..color = completedColor
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final Rect arcRect = Rect.fromCircle(center: center, radius: radius);
    final double startAngle = -pi / 2;
    final double sweepAngle = 2 * -pi * progress;

    canvas.drawArc(arcRect, startAngle, sweepAngle, false, fgPaint);

    if (progress > 0 && isNeedDonut) {
      final double endAngle = startAngle + sweepAngle;
      final Offset donutCenter = Offset(
        center.dx + radius * cos(endAngle),
        center.dy + radius * sin(endAngle),
      );

      final Paint donutPaint =
          Paint()
            ..color = completedColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = 8
            ..strokeCap = StrokeCap.round;

      final Paint donutDot =
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill
            ..strokeCap = StrokeCap.round;

      canvas.drawCircle(donutCenter, 10, donutPaint);
      canvas.drawCircle(donutCenter, 9, donutDot);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
