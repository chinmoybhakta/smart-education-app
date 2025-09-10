import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmartClock extends StatefulWidget {
  final double size;

  const SmartClock({Key? key, required this.size}) : super(key: key);

  @override
  State<SmartClock> createState() => _CustomAnalogClockState();
}

class _CustomAnalogClockState extends State<SmartClock> {
  late DateTime _currentTime;
  late StreamSubscription _timerSubscription;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startClock();
  }

  void _startClock() {
    _timerSubscription = Stream.periodic(const Duration(seconds: 1)).listen((_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }
  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: ClockPainter(_currentTime),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime currentTime;

  ClockPainter(this.currentTime);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    // Draw clock background
    canvas.drawCircle(center, radius, paint);

    // Draw hour hand
    final hourAngle = (currentTime.hour % 12 + currentTime.minute / 60) * pi / 6;
    _drawHand(canvas, center, hourAngle, radius * 0.5, Colors.white, 6);

    // Draw minute hand
    final minuteAngle = (currentTime.minute + currentTime.second / 60) * pi / 30;
    _drawHand(canvas, center, minuteAngle, radius * 0.7, Colors.blue, 4);

    // Draw second hand
    final secondAngle = currentTime.second * pi / 30;
    _drawHand(canvas, center, secondAngle, radius * 0.8, Colors.red, 2);

    // Draw center dot
    canvas.drawCircle(center, 5, Paint()..color = Colors.white);
  }

  void _drawHand(Canvas canvas, Offset center, double angle, double length,
      Color color, double width) {
    final handPaint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    final handEnd = Offset(
      center.dx + length * sin(angle),
      center.dy - length * cos(angle),
    );

    canvas.drawLine(center, handEnd, handPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}