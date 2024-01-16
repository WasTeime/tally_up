import 'package:flutter/material.dart';

class ChequeRowInfoFieldWidget extends StatelessWidget {
  final String text;
  final String value;
  final TextStyle textStyle;

  const ChequeRowInfoFieldWidget({
    super.key,
    required this.text,
    required this.value,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: textStyle),
        Text(value, style: textStyle),
      ],
    );
  }
}
