import 'package:flutter/material.dart';

class ColumnGapWidget extends StatelessWidget {
  final double height;

  const ColumnGapWidget({this.height = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
