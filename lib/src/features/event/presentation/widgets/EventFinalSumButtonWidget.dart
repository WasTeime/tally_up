import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/input_widgets/TextButtonWidget.dart';

class EventFinalSumButtonWidget extends StatelessWidget {
  final String title;
  final double sum;
  final Function() onButtonPressedEvent;

  const EventFinalSumButtonWidget({
    super.key,
    required this.title,
    required this.sum,
    required this.onButtonPressedEvent,
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
                "разделить\nпоровну",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
