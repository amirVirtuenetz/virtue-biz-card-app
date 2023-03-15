import 'dart:math';

import 'package:flutter/material.dart';

class CustomProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final Color color;

  const CustomProgressBar(
      {this.width = 80, this.height = 80, this.color = Colors.blue});

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: CustomProgressBarPainter(
          value: _animation.value,
          color: widget.color,
        ),
      ),
    );
  }
}

class CustomProgressBarPainter extends CustomPainter {
  final double value;
  final Color color;

  CustomProgressBarPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: size.width / 2),
        -90 * pi / 180,
        value * 360 * pi / 180,
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
