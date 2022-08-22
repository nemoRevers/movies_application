import 'dart:math';

import 'package:flutter/material.dart';

class ScoreIndicator extends StatelessWidget {
  final double percent;
  final double textSize;
  final FontWeight textWeight;
  final Color textColor;
  const ScoreIndicator(
      {super.key,
      required this.percent,
      required this.textSize,
      required this.textWeight,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: MyPainter(
              percent: percent,
              fillColor: Colors.black,
              lineColor: Colors.green,
              freeColor: Colors.yellow.withOpacity(0.4),
            ),
          ),
          Center(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  '${(percent * 100).toInt()}%',
                  maxLines: 1,
                  style: TextStyle(
                      color: textColor,
                      fontWeight: textWeight,
                      fontSize: textSize),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent;
  final Color fillColor;
  final Color lineColor;
  final Color freeColor;

  MyPainter(
      {required this.percent,
      required this.fillColor,
      required this.lineColor,
      required this.freeColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double widthArc = size.width / 2 * 0.15;
    final arcRect = Offset(widthArc, widthArc) &
        Size(size.width - widthArc * 2, size.height - widthArc * 2);

    drawOval(canvas, size);
    drawFreePaint(widthArc, canvas, arcRect);
    drawFilledPaint(widthArc, canvas, arcRect);
  }

  void drawOval(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = fillColor;
    canvas.drawOval(Offset.zero & size, backgroundPaint);
  }

  void drawFreePaint(double width, Canvas canvas, Rect arcRect) {
    final freePaint = Paint()
      ..color = freeColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width;

    canvas.drawArc(
      arcRect,
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      freePaint,
    );
  }

  void drawFilledPaint(double width, Canvas canvas, Rect arcRect) {
    final filledPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width;

    canvas.drawArc(
      arcRect,
      -pi / 2,
      pi * 2 * percent,
      false,
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
