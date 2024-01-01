import 'package:flutter/material.dart';

class CardTitleForGroupWidget extends StatelessWidget {
  const CardTitleForGroupWidget({
    super.key,
    required this.titleText,
    required this.peopleCount,
  });

  final String titleText;
  final int peopleCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(titleText),
        Text('$peopleCount участников'),
      ],
    );
  }
}
