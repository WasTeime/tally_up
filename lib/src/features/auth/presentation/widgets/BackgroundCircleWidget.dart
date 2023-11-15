import 'package:flutter/material.dart';

class BackgroundCircleWidget extends StatelessWidget {
  const BackgroundCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/circle.png"),
        ),
      ),
    );
  }
}
