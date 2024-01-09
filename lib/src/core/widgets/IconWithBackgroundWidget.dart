import 'package:flutter/material.dart';

class IconWithBackgroundWidget extends StatelessWidget {
  final IconData icon;

  const IconWithBackgroundWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black12),
      ),
      child: Icon(icon),
    );
  }
}
