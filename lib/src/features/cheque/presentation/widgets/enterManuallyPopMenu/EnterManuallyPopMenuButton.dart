import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tally_up/src/features/cheque/presentation/widgets/enterManuallyPopMenu/EnterManuallyPopMenuItems.dart';

class EnterManuallyPopMenuButton extends StatelessWidget {
  const EnterManuallyPopMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopover(
        context: context,
        bodyBuilder: (context) => const EnterManuallyPopMenuItems(),
        width: 250,
        height: 120,
        backgroundColor: Colors.white,
        direction: PopoverDirection.top,
      ),
      child: const Text(
        "вручную",
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Rubik',
          decoration: TextDecoration.underline,
          color: Colors.white,
          decorationColor: Colors.white,
          decorationThickness: 1,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
