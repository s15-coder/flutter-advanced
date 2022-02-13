import 'package:flutter/material.dart';
import 'package:location/helpers/markers/marker_painter.dart';

class MarkerWidget extends StatelessWidget {
  const MarkerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: MarkerPainter(
              location: 'La case del vecino de al laasasdo',
              value: '44',
              label: 'Kms',
            ),
          ),
        ),
      ),
    );
  }
}
