import 'package:flutter/material.dart';
import 'package:tally_up/src/core/widgets/IconWithBackgroundWidget.dart';

class CardTitleForEventWidget extends StatelessWidget {
  const CardTitleForEventWidget({
    super.key,
    required this.cardIcon,
    required this.titleText,
    required this.peopleCount,
  });

  final IconData cardIcon;
  final String titleText;
  final int peopleCount;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconWithBackgroundWidget(
          icon: cardIcon,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText),
            Text('$peopleCount участников'),
          ],
        ),
      ],
    );
  }
}
