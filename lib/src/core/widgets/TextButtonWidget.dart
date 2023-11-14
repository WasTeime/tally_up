import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final Function() onPressedEvent;
  final String textOnButton;

  const TextButtonWidget(this.onPressedEvent, this.textOnButton, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedEvent,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF0078FE)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(textOnButton,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Raleway-medium',
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.02,
            )),
      ),
    );
    ;
  }
}
