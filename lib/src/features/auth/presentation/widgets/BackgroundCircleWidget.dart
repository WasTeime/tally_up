import 'package:flutter/material.dart';

class BackgroundCircleWidget extends StatelessWidget {
  const BackgroundCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(),
    );

    // Container(
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage("assets/images/background.png"),
    //         fit: BoxFit.cover),
    //   ),
    // );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Color(0xFF0078FE).withOpacity(0.62);

    canvas.drawCircle(Offset(70, 50), 130, paint);
    canvas.drawCircle(Offset(15, 160), 25, paint);
    canvas.drawCircle(Offset(380, 120), 65, paint);
    canvas.drawCircle(Offset(200, 40), 45, paint);
    canvas.drawCircle(Offset(280, 210), 25, paint);
    canvas.drawCircle(Offset(300, 194), 12, paint);
    canvas.drawCircle(Offset(15, 330), 45, paint);
    canvas.drawCircle(Offset(50, 790), 110, paint);
    canvas.drawCircle(Offset(150, 820), 45, paint);
    canvas.drawCircle(Offset(380, 760), 100, paint);
    canvas.drawCircle(Offset(380, 640), 50, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
