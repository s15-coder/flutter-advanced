import 'package:flutter/material.dart';

class MarkerPainter extends CustomPainter {
  final String location;
  final String value;
  final String label;

  MarkerPainter({
    required this.location,
    required this.value,
    required this.label,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final blackPen = Paint();
    blackPen.color = Colors.purple;

    final whitePen = Paint();
    whitePen.color = Colors.white;

    const radiusBlackCircle = 20.0;
    const radiusWhiteCircle = 7.0;

    //Draw black circle
    canvas.drawCircle(
      Offset(radiusBlackCircle, size.height - radiusBlackCircle),
      radiusBlackCircle,
      blackPen,
    );

    //Draw white circle
    canvas.drawCircle(
      Offset(radiusBlackCircle, size.height - radiusBlackCircle),
      radiusWhiteCircle,
      whitePen,
    );

    //Draw white box
    final pathWhiteBox = Path();
    pathWhiteBox.moveTo(40, 15);
    pathWhiteBox.lineTo(size.width - 10, 15);
    pathWhiteBox.lineTo(size.width - 10, 90);
    pathWhiteBox.lineTo(40, 90);
    pathWhiteBox.close();
    canvas.drawShadow(pathWhiteBox, Colors.black, 8, true);
    canvas.drawPath(pathWhiteBox, whitePen);

    //Draw black box
    final pathBlackBox = Path();
    pathBlackBox.moveTo(40, 15);
    pathBlackBox.lineTo(120, 15);
    pathBlackBox.lineTo(120, 90);
    pathBlackBox.lineTo(40, 90);
    pathBlackBox.close();
    canvas.drawPath(pathBlackBox, blackPen);

    //Set minute value text.
    final minutesSpan = TextSpan(
      text: value,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
    );

    final minutesPainter = TextPainter(
      text: minutesSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 120, minWidth: 100);

    minutesPainter.paint(canvas, const Offset(30, 30));

    //Set minute label textl
    final minutesLabelSpan = TextSpan(
      text: label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w300,
      ),
    );
    final minutesLabelPainter = TextPainter(
      text: minutesLabelSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 120, minWidth: 100);
    minutesLabelPainter.paint(canvas, const Offset(30, 60));

    //Set location text

    final locatlionSpan = TextSpan(
      text: location,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
    final locatlionPainter = TextPainter(
      text: locatlionSpan,
      maxLines: 2,
      ellipsis: '...',
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 200, minWidth: 100);
    double offsetX = (location.length > 18) ? 30 : 40;
    locatlionPainter.paint(canvas, Offset(130, offsetX));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
