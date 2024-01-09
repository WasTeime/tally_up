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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.displayLarge),
                  Text('$sum рублей',
                      style: Theme.of(context).textTheme.displayMedium),
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
