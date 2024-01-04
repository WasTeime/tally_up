import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:tally_up/src/features/qr_scaner/presentation/widgets/window_items.dart';

class TextUnderline extends StatelessWidget {
  const TextUnderline({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => showPopover(
            context: context,
            bodyBuilder: (context) => WindowItems(),
            width: 250,
            height: 120,
            backgroundColor: Colors.white,
            direction: PopoverDirection.top),
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
      ),
    );
    ;
  }
}
