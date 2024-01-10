import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final Function() onPressedEvent;
  final String textOnButton;

  const TextButtonWidget(this.onPressedEvent, this.textOnButton, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: TextButton(
          onPressed: onPressedEvent,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFF0078FE)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.headlineLarge,
              child: Text(
                textOnButton,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
