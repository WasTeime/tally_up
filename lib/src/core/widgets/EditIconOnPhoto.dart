import 'package:flutter/material.dart';

class EditIconOnPhoto extends StatelessWidget {
  final Color color;

  const EditIconOnPhoto({required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleWidget(
      color: Colors.white,
      all: 3,
      child: CircleWidget(
        color: const Color(0XFF0079FF),
        all: 8,
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final Widget child;
  final double all;
  final Color color;

  const CircleWidget({
    required this.child,
    required this.all,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
