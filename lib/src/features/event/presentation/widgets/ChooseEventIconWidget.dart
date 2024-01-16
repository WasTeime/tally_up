import 'package:flutter/material.dart';
import 'package:tally_up/src/features/group/presentation/widgets/view.dart';

class ChooseEventIconWidget extends StatelessWidget {
  const ChooseEventIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => const [
        PopupMenuItem(
          child: Row(
            children: [
              IconWithBackgroundWidget(icon: Icons.abc),
              SizedBox(
                width: 20,
              ),
              Text('Мероприятие 1')
            ],
          ),
        ),
        PopupMenuItem(child: IconWithBackgroundWidget(icon: Icons.abc)),
        PopupMenuItem(child: IconWithBackgroundWidget(icon: Icons.abc))
      ],
    );
  }
}
