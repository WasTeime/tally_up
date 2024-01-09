import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/input_widgets/TextButtonWidget.dart';

class FinalSumButtonWidget extends StatelessWidget {
  final String title;
  final String sum;
  final String buttonText;
  final Function() onButtonPressedEvent;

  const FinalSumButtonWidget({
    super.key,
    required this.title,
    required this.sum,
    required this.onButtonPressedEvent,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text('$sum рублей'),
                ],
              ),
              TextButtonWidget(
                onButtonPressedEvent,
                buttonText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
