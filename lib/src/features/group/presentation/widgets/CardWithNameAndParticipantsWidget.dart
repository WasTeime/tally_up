import 'package:flutter/material.dart';
import 'package:tally_up/src/features/group/presentation/widgets/view.dart';

class CardWithNameAndParticipantsWidget extends StatelessWidget {
  final String titleText;
  final int peopleCount;
  final IconData cardIcon;
  final bool isCardForGroup;
  final EdgeInsets _paddingForCard =
      const EdgeInsets.symmetric(horizontal: 25, vertical: 5);

  const CardWithNameAndParticipantsWidget({
    super.key,
    this.cardIcon = Icons.abc,
    required this.titleText,
    required this.peopleCount,
    required this.isCardForGroup,
  });

  const CardWithNameAndParticipantsWidget.forEvent({
    super.key,
    required this.cardIcon,
    required this.titleText,
    required this.peopleCount,
    this.isCardForGroup = false,
  });

  const CardWithNameAndParticipantsWidget.forGroup({
    super.key,
    this.cardIcon = Icons.abc,
    required this.titleText,
    required this.peopleCount,
    this.isCardForGroup = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: _paddingForCard,
        child: isCardForGroup
            ? CardTitleForGroupWidget(
                titleText: titleText,
                peopleCount: peopleCount,
              )
            : CardTitleForEventWidget(
                cardIcon: cardIcon,
                titleText: titleText,
                peopleCount: peopleCount,
              ),
      ),
    );
  }
}
