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
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon),
    );
  }
}
