// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class AnimantedLineWidget extends StatefulWidget {
  final int goal;
  final int eaten;
  final Color completedColor;
  final double size;
  const AnimantedLineWidget({
    super.key,
    required this.goal,
    required this.eaten,
    required this.completedColor,
    this.size = 32,
  });

  @override
  _AnimantedLineWidgetState createState() => _AnimantedLineWidgetState();
}

class _AnimantedLineWidgetState extends State<AnimantedLineWidget>
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
      width: 10,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: Size(1, widget.size),
                painter: _LinePainter(
                  progress: _animation.value,
                  completedColor: widget.completedColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  final double progress;
  final Color completedColor;

  _LinePainter({required this.progress, required this.completedColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double fullHeight = size.height;
    final double progressHeight = fullHeight * progress;

    final Paint bgPaint =
        Paint()
          ..color = Color(0xFFF0F0F0)
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    final Paint fgPaint =
        Paint()
          ..color = completedColor
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, fullHeight), Offset(0, 0), bgPaint);

    canvas.drawLine(
      Offset(0, fullHeight),
      Offset(0, fullHeight - progressHeight),
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
