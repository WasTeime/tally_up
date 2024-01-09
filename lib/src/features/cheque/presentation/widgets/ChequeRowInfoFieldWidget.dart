import 'package:flutter/material.dart';

class ChequeRowInfoFieldWidget extends StatelessWidget {
  final String text;
  final String value;

  const ChequeRowInfoFieldWidget({
    super.key,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Text(value),
      ],
    );
  }
}
